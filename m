Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from smtp.citrix.com ([66.165.176.89])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1USsnF-0004rv-P3
 for kexec@lists.infradead.org; Thu, 18 Apr 2013 17:38:47 +0000
Message-ID: <51702F9F.30500@citrix.com>
Date: Thu, 18 Apr 2013 18:38:39 +0100
From: David Vrabel <david.vrabel@citrix.com>
MIME-Version: 1.0
Subject: Re: [Xen-devel] [PATCHv4 0/8] kexec: extend kexec hypercall for use
 with pv-ops kernels
References: <1366132390-5269-1-git-send-email-david.vrabel@citrix.com>
 <20130417123437.GA906@debian70-amd64.local.net-space.pl>
In-Reply-To: <20130417123437.GA906@debian70-amd64.local.net-space.pl>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Daniel Kiper <daniel.kiper@oracle.com>
Cc: Keir Fraser <keir@xen.org>, kexec@lists.infradead.org, xen-devel@lists.xen.org

On 17/04/13 13:34, Daniel Kiper wrote:
> 
> kexec -e still does not work. I see in my console:
> 
> I'm in purgatory
> sha256 digests do not match :(

I have now fixed this.  Xen was not probably zeroing out trailing pages
(only partial pages) when loading a default image (crash was fine).

The kernel does this by allocating and clearing pages and then
relocating these as normal but it's wasteful to allocate a bunch of
empty pages so I added a IND_ZERO entry type for the indirection pages
which gets the relocation code to zero the destination.

See the kexec-v5 branch at:

http://xenbits.xen.org/gitweb/?p=people/dvrabel/xen.git;a=summary

I shall repost this series again once the 4.4 development window is open.

--- a/xen/arch/x86/x86_64/kexec_reloc.S
+++ b/xen/arch/x86/x86_64/kexec_reloc.S
@@ -130,13 +130,18 @@ relocate_pages:
         jmp     3f
 2:
         testq   $0x8,   %rcx  /* is it the source indicator? */
-        jz      0b            /* Ignore it otherwise */
+        jz      2f
         movq    %rcx,   %rsi  /* For ever source page do a copy */
         andq    $0xfffffffffffff000, %rsi
-
         movq    $512,   %rcx
         rep movsq
-
+        jmp     0b
+2:
+        testq   $0x10,  %rcx  /* is it the zero indicator? */
+        jz      0b            /* Ignore it otherwise */
+        movq    $512,   %rcx  /* Zero the destination page. */
+        xorq    %rax,   %rax
+        rep stosq
         jmp     0b
 3:
         ret
diff --git a/xen/common/kimage.c b/xen/common/kimage.c
index 86261ca..1cc0ef7 100644
--- a/xen/common/kimage.c
+++ b/xen/common/kimage.c
@@ -661,7 +661,7 @@ static int kimage_load_normal_segment(struct
kexec_image *image,
 {
     unsigned long to_copy;
     unsigned long src_offset;
-    paddr_t dest;
+    paddr_t dest, end;
     int ret;

     to_copy = segment->buf_size;
@@ -675,15 +675,13 @@ static int kimage_load_normal_segment(struct
kexec_image *image,
     while ( to_copy )
     {
         unsigned long dest_mfn;
-        size_t dest_off;
         struct page_info *page;
         void *dest_va;
         size_t size;

         dest_mfn = dest >> PAGE_SHIFT;
-        dest_off = dest & ~PAGE_MASK;

-        size = min(PAGE_SIZE - dest_off, to_copy);
+        size = min_t(unsigned long, PAGE_SIZE, to_copy);

         page = kimage_alloc_page(image, dest);
         if ( !page )
@@ -693,16 +691,21 @@ static int kimage_load_normal_segment(struct
kexec_image *image,
             return ret;

         dest_va = __map_domain_page(page);
-        ret = copy_from_guest_offset(dest_va + dest_off, segment->buf,
src_offset, size);
+        ret = copy_from_guest_offset(dest_va, segment->buf, src_offset,
size);
         unmap_domain_page(dest_va);
         if ( ret )
             return -EFAULT;

         to_copy -= size;
         src_offset += size;
-        dest += size;
+        dest += PAGE_SIZE;
     }

+    /* Remainder of the destination should be zeroed. */
+    end = segment->dest_maddr + segment->dest_size;
+    for ( ; dest < end; dest += PAGE_SIZE )
+        kimage_add_entry(image, IND_ZERO);
+
     return 0;
 }

--- a/xen/include/xen/kimage.h
+++ b/xen/include/xen/kimage.h
@@ -14,6 +14,7 @@ typedef paddr_t kimage_entry_t;
 #define IND_INDIRECTION  0x2
 #define IND_DONE         0x4
 #define IND_SOURCE       0x8
+#define IND_ZERO        0x10

 struct kexec_image {
     uint8_t type;

David

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
