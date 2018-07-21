Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from duke.felloff.net ([216.126.196.34])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fgynx-0004O6-Gc
 for kexec@lists.infradead.org; Sat, 21 Jul 2018 20:48:43 +0000
Message-ID: <AF06B5E4673780020CB53F122CB0C704@felloff.net>
Subject: why's svgadrmfb not exposing linear phys framebuffer address?
Date: Sat, 21 Jul 2018 22:48:23 +0200
From: cinap_lenrek@felloff.net
MIME-Version: 1.0
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

https://www.kernel.org/doc/Documentation/fb/api.txt

according to this, fb_fix_screeninfo struct should have the
physical start address and stride of the framebuffer. but
it lies: giving me *ZERO* for smem_start. driver id is
"svgadrmfb".

is there any other linux interface to get to the phyical
framebuffer address that actually works?

--
cinap

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
