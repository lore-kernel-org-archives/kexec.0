Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-wy0-f177.google.com ([74.125.82.177])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1PmpMv-0003Rf-HA
	for kexec@lists.infradead.org; Tue, 08 Feb 2011 15:20:42 +0000
Received: by mail-wy0-f177.google.com with SMTP id 22so5690472wyf.36
	for <kexec@lists.infradead.org>; Tue, 08 Feb 2011 07:20:41 -0800 (PST)
Date: Tue, 8 Feb 2011 17:20:36 +0200
From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Subject: [PATCH] kexec-tools: Don't duplicate the bzImage header area
Message-ID: <20110208152036.GA6615@laptop>
MIME-Version: 1.0
Content-Disposition: inline
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>, Vivek Goyal <vgoyal@redhat.com>, Haren Myneni <hbabu@us.ibm.com>, Eric Biederman <ebiederm@xmission.com>
Cc: kexec@lists.infradead.org

Hi,

Don't wholeheartedly copy the 32-Kbytes bzImage header area to the stack,
just use a constant pointer instead.

Signed-off-by: Ahmed S. Darwish <darwish.07@gmail.com>
---

(If this is accepted, I'll send a similar patch for the setup header)

diff --git a/kexec/arch/i386/kexec-bzImage.c b/kexec/arch/i386/kexec-bzImage.c
index 83d3a69..2312eb8 100644
--- a/kexec/arch/i386/kexec-bzImage.c
+++ b/kexec/arch/i386/kexec-bzImage.c
@@ -43,32 +43,32 @@ static const int probe_debug = 0;
 
 int bzImage_probe(const char *buf, off_t len)
 {
-	struct x86_linux_header header;
+	const struct x86_linux_header *header;
 	if ((uintmax_t)len < (uintmax_t)sizeof(header)) {
 		return -1;
 	}
-	memcpy(&header, buf, sizeof(header));
-	if (memcmp(header.header_magic, "HdrS", 4) != 0) {
+	header = (void *)buf;
+	if (memcmp(header->header_magic, "HdrS", 4) != 0) {
 		if (probe_debug) {
 			fprintf(stderr, "Not a bzImage\n");
 		}
 		return -1;
 	}
-	if (header.boot_sector_magic != 0xAA55) {
+	if (header->boot_sector_magic != 0xAA55) {
 		if (probe_debug) {
 			fprintf(stderr, "No x86 boot sector present\n");
 		}
 		/* No x86 boot sector present */
 		return -1;
 	}
-	if (header.protocol_version < 0x0200) {
+	if (header->protocol_version < 0x0200) {
 		if (probe_debug) {
 			fprintf(stderr, "Must be at least protocol version 2.00\n");
 		}
 		/* Must be at least protocol version 2.00 */
 		return -1;
 	}
-	if ((header.loadflags & 1) == 0) {
+	if ((header->loadflags & 1) == 0) {
 		if (probe_debug) {
 			fprintf(stderr, "zImage not a bzImage\n");
 		}

thanks,

-- 
Darwish
http://darwish.07.googlepages.com

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
