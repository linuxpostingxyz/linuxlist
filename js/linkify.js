// cspell: ignore linkify

function linkifyUsernames(root) {
    const usernameRegex = /@([a-zA-Z0-9\-]{1,32})/g;

    function processTextNode(node) {
        const text = node.nodeValue;
        let match, lastIndex = 0;
        const frag = document.createDocumentFragment();

        usernameRegex.lastIndex = 0;
        while ((match = usernameRegex.exec(text)) !== null) {
            // Text before the match
            if (match.index > lastIndex) {
                frag.appendChild(document.createTextNode(text.slice(lastIndex, match.index)));
            }
            // Create the <a> element
            const a = document.createElement('a');
            a.href = `https://tumblr.com/${match[1]}`;
            a.textContent = match[0];
            a.target = '_blank';
            frag.appendChild(a);
            lastIndex = usernameRegex.lastIndex;
        }
        // Remaining text
        if (lastIndex < text.length) {
            frag.appendChild(document.createTextNode(text.slice(lastIndex)));
        }
        node.parentNode.replaceChild(frag, node);
    }

    function walk(node) {
        if (!node) return;
        // Skip <a>, <script>, <style>, <textarea>
        if (node.nodeType === 1 && /^(A|SCRIPT|STYLE|TEXTAREA)$/i.test(node.tagName)) return;
        if (node.nodeType === 3 && usernameRegex.test(node.nodeValue)) {
            processTextNode(node);
            return;
        }
        // Use a static array to avoid issues if the DOM changes during traversal
        const children = Array.from(node.childNodes);
        for (const child of children) {
            walk(child);
        }
    }

    walk(root);
}

addEventListener('DOMContentLoaded', () => {
    linkifyUsernames(document.body);
});