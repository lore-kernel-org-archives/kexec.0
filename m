Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-ew0-f49.google.com ([209.85.215.49])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QlOuS-0002hJ-Er
	for kexec@lists.infradead.org; Mon, 25 Jul 2011 17:25:42 +0000
Received: by ewy3 with SMTP id 3so3200484ewy.36
	for <kexec@lists.infradead.org>; Mon, 25 Jul 2011 10:25:36 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 25 Jul 2011 22:55:35 +0530
Message-ID: <CANaZ7Nx_GuBFkKw6O_gSqOGC0fVDX0MT959sSPyDTb1u+yFPhg@mail.gmail.com>
Subject: [PATCH]: fix makedumpfile cache page exclusion dump levels.
From: Thayumanavar S <thayumker@gmail.com>
Content-Type: multipart/mixed; boundary=00504502d1266a714804a8e81a84
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: tachibana@mxm.nes.nec.co.jp, kumagai-atsushi@mxc.nes.nec.co.jp, kexec@lists.infradead.org

--00504502d1266a714804a8e81a84
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Looking at the code in depth the condition for exclusion of cache
private seem to exclude cache pages including private pages. The
levels cache page ( exclude private ) and cache private (cache page
with private) need to be mutually exclusive.The following patch fixes
this:

Signed-off-by: thayumker@gmail.com
diff --git a/makedumpfile.8 b/makedumpfile.8
index b9a3bf0..dd7960b 100644
--- a/makedumpfile.8
+++ b/makedumpfile.8
@@ -138,32 +138,32 @@ by dump_level 11, makedumpfile retries it by
dump_level 31.
      1 |  X   |      |       |      |
      2 |      |  X   |       |      |
      3 |  X   |  X   |       |      |
-     4 |      |  X   |  X    |      |
-     5 |  X   |  X   |  X    |      |
+     4 |      |      |  X    |      |
+     5 |  X   |      |  X    |      |
      6 |      |  X   |  X    |      |
      7 |  X   |  X   |  X    |      |
      8 |      |      |       |  X   |
      9 |  X   |      |       |  X   |
     10 |      |  X   |       |  X   |
     11 |  X   |  X   |       |  X   |
-    12 |      |  X   |  X    |  X   |
-    13 |  X   |  X   |  X    |  X   |
+    12 |      |      |  X    |  X   |
+    13 |  X   |      |  X    |  X   |
     14 |      |  X   |  X    |  X   |
     15 |  X   |  X   |  X    |  X   |
     16 |      |      |       |      |  X
     17 |  X   |      |       |      |  X
     18 |      |  X   |       |      |  X
     19 |  X   |  X   |       |      |  X
-    20 |      |  X   |  X    |      |  X
-    21 |  X   |  X   |  X    |      |  X
+    20 |      |      |  X    |      |  X
+    21 |  X   |      |  X    |      |  X
     22 |      |  X   |  X    |      |  X
     23 |  X   |  X   |  X    |      |  X
     24 |      |      |       |  X   |  X
     25 |  X   |      |       |  X   |  X
     26 |      |  X   |       |  X   |  X
     27 |  X   |  X   |       |  X   |  X
-    28 |      |  X   |  X    |  X   |  X
-    29 |  X   |  X   |  X    |  X   |  X
+    28 |      |      |  X    |  X   |  X
+    29 |  X   |      |  X    |  X   |  X
     30 |      |  X   |  X    |  X   |  X
     31 |  X   |  X   |  X    |  X   |  X

diff --git a/makedumpfile.c b/makedumpfile.c
index 7d0c663..e117f31 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -5015,7 +5015,7 @@ __exclude_unnecessary_pages(unsigned long mem_map,
                 */
                else if ((info->dump_level & DL_EXCLUDE_CACHE_PRI)
                    && (isLRU(flags) || isSwapCache(flags))
-                   && !isAnon(mapping)) {
+                   && isPrivate(flags) && !isAnon(mapping)) {
                        clear_bit_on_2nd_bitmap_for_kernel(pfn);
                        pfn_cache_private++;
                }


or
Correct the makedumpfile man making it more explicit so that the
end-users can understand.The following patch fixes this:
--- a/makedumpfile.8
+++ b/makedumpfile.8
@@ -130,42 +130,43 @@ by dump_level 11, makedumpfile retries it by
dump_level 31.
 .br
 # makedumpfile \-d 11,31 \-x vmlinux /proc/vmcore dumpfile

-  dump | zero | cache|cache  | user | free
- level | page | page |private| data | page
+  dump | zero | cache page   |cache page    | user | free
+ level | page | (exlude priv)|(include priv)| data | page
+       |      |
 .br
 \-\-\-\-\-\-\-+\-\-\-\-\-\-+\-\-\-\-\-\-+\-\-\-\-\-\-\-+\-\-\-\-\-\-+\-\-\=
-\-\-\-
-     0 |      |      |       |      |
-     1 |  X   |      |       |      |
-     2 |      |  X   |       |      |
-     3 |  X   |  X   |       |      |
-     4 |      |  X   |  X    |      |
-     5 |  X   |  X   |  X    |      |
-     6 |      |  X   |  X    |      |
-     7 |  X   |  X   |  X    |      |
-     8 |      |      |       |  X   |
-     9 |  X   |      |       |  X   |
-    10 |      |  X   |       |  X   |
-    11 |  X   |  X   |       |  X   |
-    12 |      |  X   |  X    |  X   |
-    13 |  X   |  X   |  X    |  X   |
-    14 |      |  X   |  X    |  X   |
-    15 |  X   |  X   |  X    |  X   |
-    16 |      |      |       |      |  X
-    17 |  X   |      |       |      |  X
-    18 |      |  X   |       |      |  X
-    19 |  X   |  X   |       |      |  X
-    20 |      |  X   |  X    |      |  X
-    21 |  X   |  X   |  X    |      |  X
-    22 |      |  X   |  X    |      |  X
-    23 |  X   |  X   |  X    |      |  X
-    24 |      |      |       |  X   |  X
-    25 |  X   |      |       |  X   |  X
-    26 |      |  X   |       |  X   |  X
-    27 |  X   |  X   |       |  X   |  X
-    28 |      |  X   |  X    |  X   |  X
-    29 |  X   |  X   |  X    |  X   |  X
-    30 |      |  X   |  X    |  X   |  X
-    31 |  X   |  X   |  X    |  X   |  X
+     0 |      |              |              |      |
+     1 |  X   |              |              |      |
+     2 |      |              |  X           |      |
+     3 |  X   |              |  X           |      |
+     4 |      |  X           |  X           |      |
+     5 |  X   |  X           |  X           |      |
+     6 |      |  X           |  X           |      |
+     7 |  X   |  X           |  X           |      |
+     8 |      |              |              |  X   |
+     9 |  X   |              |              |  X   |
+    10 |      |              |  X           |  X   |
+    11 |  X   |              |  X           |  X   |
+    12 |      |  X           |  X           |  X   |
+    13 |  X   |  X           |  X           |  X   |
+    14 |      |  X           |  X           |  X   |
+    15 |  X   |  X           |  X           |  X   |
+    16 |      |              |              |      |  X
+    17 |  X   |              |              |      |  X
+    18 |      |              |  X           |      |  X
+    19 |  X   |              |  X           |      |  X
+    20 |      |  X           |  X           |      |  X
+    21 |  X   |  X           |  X           |      |  X
+    22 |      |  X           |  X           |      |  X
+    23 |  X   |  X           |  X           |      |  X
+    24 |      |              |              |  X   |  X
+    25 |  X   |              |              |  X   |  X
+    26 |      |              |  X           |  X   |  X
+    27 |  X   |              |  X           |  X   |  X
+    28 |      |  X           |  X           |  X   |  X
+    29 |  X   |  X           |  X           |  X   |  X
+    30 |      |  X           |  X           |  X   |  X
+    31 |  X   |  X           |  X           |  X   |  X


 .TP


On Sat, Jul 9, 2011 at 9:49 AM, Thayumanavar S <thayumker@gmail.com> wrote:
> I believe that makedumpfile man page which descirbe the dump file and
> corressponding page exclusion table appears to have incorrect
> inentries ( such as 5&7 having value,likewise 29&31) and not following
> the bitmask as mentioned in the code.
> Below code fixes this issue.
>
> Signed-off-by: thayumker@gmail.com
> diff --git a/makedumpfile.8 b/makedumpfile.8
> index b9a3bf0..dd7960b 100644
> --- a/makedumpfile.8
> +++ b/makedumpfile.8
> @@ -138,32 +138,32 @@ by dump_level 11, makedumpfile retries it by
> dump_level 31.
> =A0 =A0 =A01 | =A0X =A0 | =A0 =A0 =A0| =A0 =A0 =A0 | =A0 =A0 =A0|
> =A0 =A0 =A02 | =A0 =A0 =A0| =A0X =A0 | =A0 =A0 =A0 | =A0 =A0 =A0|
> =A0 =A0 =A03 | =A0X =A0 | =A0X =A0 | =A0 =A0 =A0 | =A0 =A0 =A0|
> - =A0 =A0 4 | =A0 =A0 =A0| =A0X =A0 | =A0X =A0 =A0| =A0 =A0 =A0|
> - =A0 =A0 5 | =A0X =A0 | =A0X =A0 | =A0X =A0 =A0| =A0 =A0 =A0|
> + =A0 =A0 4 | =A0 =A0 =A0| =A0 =A0 =A0| =A0X =A0 =A0| =A0 =A0 =A0|
> + =A0 =A0 5 | =A0X =A0 | =A0 =A0 =A0| =A0X =A0 =A0| =A0 =A0 =A0|
> =A0 =A0 =A06 | =A0 =A0 =A0| =A0X =A0 | =A0X =A0 =A0| =A0 =A0 =A0|
> =A0 =A0 =A07 | =A0X =A0 | =A0X =A0 | =A0X =A0 =A0| =A0 =A0 =A0|
> =A0 =A0 =A08 | =A0 =A0 =A0| =A0 =A0 =A0| =A0 =A0 =A0 | =A0X =A0 |
> =A0 =A0 =A09 | =A0X =A0 | =A0 =A0 =A0| =A0 =A0 =A0 | =A0X =A0 |
> =A0 =A0 10 | =A0 =A0 =A0| =A0X =A0 | =A0 =A0 =A0 | =A0X =A0 |
> =A0 =A0 11 | =A0X =A0 | =A0X =A0 | =A0 =A0 =A0 | =A0X =A0 |
> - =A0 =A012 | =A0 =A0 =A0| =A0X =A0 | =A0X =A0 =A0| =A0X =A0 |
> - =A0 =A013 | =A0X =A0 | =A0X =A0 | =A0X =A0 =A0| =A0X =A0 |
> + =A0 =A012 | =A0 =A0 =A0| =A0 =A0 =A0| =A0X =A0 =A0| =A0X =A0 |
> + =A0 =A013 | =A0X =A0 | =A0 =A0 =A0| =A0X =A0 =A0| =A0X =A0 |
> =A0 =A0 14 | =A0 =A0 =A0| =A0X =A0 | =A0X =A0 =A0| =A0X =A0 |
> =A0 =A0 15 | =A0X =A0 | =A0X =A0 | =A0X =A0 =A0| =A0X =A0 |
> =A0 =A0 16 | =A0 =A0 =A0| =A0 =A0 =A0| =A0 =A0 =A0 | =A0 =A0 =A0| =A0X
> =A0 =A0 17 | =A0X =A0 | =A0 =A0 =A0| =A0 =A0 =A0 | =A0 =A0 =A0| =A0X
> =A0 =A0 18 | =A0 =A0 =A0| =A0X =A0 | =A0 =A0 =A0 | =A0 =A0 =A0| =A0X
> =A0 =A0 19 | =A0X =A0 | =A0X =A0 | =A0 =A0 =A0 | =A0 =A0 =A0| =A0X
> - =A0 =A020 | =A0 =A0 =A0| =A0X =A0 | =A0X =A0 =A0| =A0 =A0 =A0| =A0X
> - =A0 =A021 | =A0X =A0 | =A0X =A0 | =A0X =A0 =A0| =A0 =A0 =A0| =A0X
> + =A0 =A020 | =A0 =A0 =A0| =A0 =A0 =A0| =A0X =A0 =A0| =A0 =A0 =A0| =A0X
> + =A0 =A021 | =A0X =A0 | =A0 =A0 =A0| =A0X =A0 =A0| =A0 =A0 =A0| =A0X
> =A0 =A0 22 | =A0 =A0 =A0| =A0X =A0 | =A0X =A0 =A0| =A0 =A0 =A0| =A0X
> =A0 =A0 23 | =A0X =A0 | =A0X =A0 | =A0X =A0 =A0| =A0 =A0 =A0| =A0X
> =A0 =A0 24 | =A0 =A0 =A0| =A0 =A0 =A0| =A0 =A0 =A0 | =A0X =A0 | =A0X
> =A0 =A0 25 | =A0X =A0 | =A0 =A0 =A0| =A0 =A0 =A0 | =A0X =A0 | =A0X
> =A0 =A0 26 | =A0 =A0 =A0| =A0X =A0 | =A0 =A0 =A0 | =A0X =A0 | =A0X
> =A0 =A0 27 | =A0X =A0 | =A0X =A0 | =A0 =A0 =A0 | =A0X =A0 | =A0X
> - =A0 =A028 | =A0 =A0 =A0| =A0X =A0 | =A0X =A0 =A0| =A0X =A0 | =A0X
> - =A0 =A029 | =A0X =A0 | =A0X =A0 | =A0X =A0 =A0| =A0X =A0 | =A0X
> + =A0 =A028 | =A0 =A0 =A0| =A0 =A0 =A0| =A0X =A0 =A0| =A0X =A0 | =A0X
> + =A0 =A029 | =A0X =A0 | =A0 =A0 =A0| =A0X =A0 =A0| =A0X =A0 | =A0X
> =A0 =A0 30 | =A0 =A0 =A0| =A0X =A0 | =A0X =A0 =A0| =A0X =A0 | =A0X
> =A0 =A0 31 | =A0X =A0 | =A0X =A0 | =A0X =A0 =A0| =A0X =A0 | =A0X
>

--00504502d1266a714804a8e81a84
Content-Type: text/plain; charset=US-ASCII; name="diff1.txt"
Content-Disposition: attachment; filename="diff1.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gqjpi3ds0

ZGlmZiAtLWdpdCBhL21ha2VkdW1wZmlsZS44IGIvbWFrZWR1bXBmaWxlLjgKaW5kZXggYjlhM2Jm
MC4uZGQ3OTYwYiAxMDA2NDQKLS0tIGEvbWFrZWR1bXBmaWxlLjgKKysrIGIvbWFrZWR1bXBmaWxl
LjgKQEAgLTEzOCwzMiArMTM4LDMyIEBAIGJ5IGR1bXBfbGV2ZWwgMTEsIG1ha2VkdW1wZmlsZSBy
ZXRyaWVzIGl0IGJ5IGR1bXBfbGV2ZWwgMzEuCiAgICAgIDEgfCAgWCAgIHwgICAgICB8ICAgICAg
IHwgICAgICB8CiAgICAgIDIgfCAgICAgIHwgIFggICB8ICAgICAgIHwgICAgICB8CiAgICAgIDMg
fCAgWCAgIHwgIFggICB8ICAgICAgIHwgICAgICB8Ci0gICAgIDQgfCAgICAgIHwgIFggICB8ICBY
ICAgIHwgICAgICB8Ci0gICAgIDUgfCAgWCAgIHwgIFggICB8ICBYICAgIHwgICAgICB8CisgICAg
IDQgfCAgICAgIHwgICAgICB8ICBYICAgIHwgICAgICB8CisgICAgIDUgfCAgWCAgIHwgICAgICB8
ICBYICAgIHwgICAgICB8CiAgICAgIDYgfCAgICAgIHwgIFggICB8ICBYICAgIHwgICAgICB8CiAg
ICAgIDcgfCAgWCAgIHwgIFggICB8ICBYICAgIHwgICAgICB8CiAgICAgIDggfCAgICAgIHwgICAg
ICB8ICAgICAgIHwgIFggICB8CiAgICAgIDkgfCAgWCAgIHwgICAgICB8ICAgICAgIHwgIFggICB8
CiAgICAgMTAgfCAgICAgIHwgIFggICB8ICAgICAgIHwgIFggICB8CiAgICAgMTEgfCAgWCAgIHwg
IFggICB8ICAgICAgIHwgIFggICB8Ci0gICAgMTIgfCAgICAgIHwgIFggICB8ICBYICAgIHwgIFgg
ICB8Ci0gICAgMTMgfCAgWCAgIHwgIFggICB8ICBYICAgIHwgIFggICB8CisgICAgMTIgfCAgICAg
IHwgICAgICB8ICBYICAgIHwgIFggICB8CisgICAgMTMgfCAgWCAgIHwgICAgICB8ICBYICAgIHwg
IFggICB8CiAgICAgMTQgfCAgICAgIHwgIFggICB8ICBYICAgIHwgIFggICB8CiAgICAgMTUgfCAg
WCAgIHwgIFggICB8ICBYICAgIHwgIFggICB8CiAgICAgMTYgfCAgICAgIHwgICAgICB8ICAgICAg
IHwgICAgICB8ICBYCiAgICAgMTcgfCAgWCAgIHwgICAgICB8ICAgICAgIHwgICAgICB8ICBYCiAg
ICAgMTggfCAgICAgIHwgIFggICB8ICAgICAgIHwgICAgICB8ICBYCiAgICAgMTkgfCAgWCAgIHwg
IFggICB8ICAgICAgIHwgICAgICB8ICBYCi0gICAgMjAgfCAgICAgIHwgIFggICB8ICBYICAgIHwg
ICAgICB8ICBYCi0gICAgMjEgfCAgWCAgIHwgIFggICB8ICBYICAgIHwgICAgICB8ICBYCisgICAg
MjAgfCAgICAgIHwgICAgICB8ICBYICAgIHwgICAgICB8ICBYCisgICAgMjEgfCAgWCAgIHwgICAg
ICB8ICBYICAgIHwgICAgICB8ICBYCiAgICAgMjIgfCAgICAgIHwgIFggICB8ICBYICAgIHwgICAg
ICB8ICBYCiAgICAgMjMgfCAgWCAgIHwgIFggICB8ICBYICAgIHwgICAgICB8ICBYCiAgICAgMjQg
fCAgICAgIHwgICAgICB8ICAgICAgIHwgIFggICB8ICBYCiAgICAgMjUgfCAgWCAgIHwgICAgICB8
ICAgICAgIHwgIFggICB8ICBYCiAgICAgMjYgfCAgICAgIHwgIFggICB8ICAgICAgIHwgIFggICB8
ICBYCiAgICAgMjcgfCAgWCAgIHwgIFggICB8ICAgICAgIHwgIFggICB8ICBYCi0gICAgMjggfCAg
ICAgIHwgIFggICB8ICBYICAgIHwgIFggICB8ICBYCi0gICAgMjkgfCAgWCAgIHwgIFggICB8ICBY
ICAgIHwgIFggICB8ICBYCisgICAgMjggfCAgICAgIHwgICAgICB8ICBYICAgIHwgIFggICB8ICBY
CisgICAgMjkgfCAgWCAgIHwgICAgICB8ICBYICAgIHwgIFggICB8ICBYCiAgICAgMzAgfCAgICAg
IHwgIFggICB8ICBYICAgIHwgIFggICB8ICBYCiAgICAgMzEgfCAgWCAgIHwgIFggICB8ICBYICAg
IHwgIFggICB8ICBYCiAKZGlmZiAtLWdpdCBhL21ha2VkdW1wZmlsZS5jIGIvbWFrZWR1bXBmaWxl
LmMKaW5kZXggN2QwYzY2My4uZTExN2YzMSAxMDA2NDQKLS0tIGEvbWFrZWR1bXBmaWxlLmMKKysr
IGIvbWFrZWR1bXBmaWxlLmMKQEAgLTUwMTUsNyArNTAxNSw3IEBAIF9fZXhjbHVkZV91bm5lY2Vz
c2FyeV9wYWdlcyh1bnNpZ25lZCBsb25nIG1lbV9tYXAsCiAJCSAqLwogCQllbHNlIGlmICgoaW5m
by0+ZHVtcF9sZXZlbCAmIERMX0VYQ0xVREVfQ0FDSEVfUFJJKQogCQkgICAgJiYgKGlzTFJVKGZs
YWdzKSB8fCBpc1N3YXBDYWNoZShmbGFncykpCi0JCSAgICAmJiAhaXNBbm9uKG1hcHBpbmcpKSB7
CisJCSAgICAmJiBpc1ByaXZhdGUoZmxhZ3MpICYmICFpc0Fub24obWFwcGluZykpIHsKIAkJCWNs
ZWFyX2JpdF9vbl8ybmRfYml0bWFwX2Zvcl9rZXJuZWwocGZuKTsKIAkJCXBmbl9jYWNoZV9wcml2
YXRlKys7CiAJCX0K
--00504502d1266a714804a8e81a84
Content-Type: text/plain; charset=US-ASCII; name="patch_alt.txt"
Content-Disposition: attachment; filename="patch_alt.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gqjpiwk21

ZGlmZiAtLWdpdCBhL21ha2VkdW1wZmlsZS44IGIvbWFrZWR1bXBmaWxlLjgKaW5kZXggYjlhM2Jm
MC4uMjdmZTdkMiAxMDA2NDQKLS0tIGEvbWFrZWR1bXBmaWxlLjgKKysrIGIvbWFrZWR1bXBmaWxl
LjgKQEAgLTEzMCw0MiArMTMwLDQzIEBAIGJ5IGR1bXBfbGV2ZWwgMTEsIG1ha2VkdW1wZmlsZSBy
ZXRyaWVzIGl0IGJ5IGR1bXBfbGV2ZWwgMzEuCiAuYnIKICMgbWFrZWR1bXBmaWxlIFwtZCAxMSwz
MSBcLXggdm1saW51eCAvcHJvYy92bWNvcmUgZHVtcGZpbGUKIAotICBkdW1wIHwgemVybyB8IGNh
Y2hlfGNhY2hlICB8IHVzZXIgfCBmcmVlCi0gbGV2ZWwgfCBwYWdlIHwgcGFnZSB8cHJpdmF0ZXwg
ZGF0YSB8IHBhZ2UKKyAgZHVtcCB8IHplcm8gfCBjYWNoZSBwYWdlICAgfGNhY2hlIHBhZ2UgICAg
fCB1c2VyIHwgZnJlZQorIGxldmVsIHwgcGFnZSB8IChleGx1ZGUgcHJpdil8KGluY2x1ZGUgcHJp
dil8IGRhdGEgfCBwYWdlCisgICAgICAgfCAgICAgIHwgCiAuYnIKIFwtXC1cLVwtXC1cLVwtK1wt
XC1cLVwtXC1cLStcLVwtXC1cLVwtXC0rXC1cLVwtXC1cLVwtXC0rXC1cLVwtXC1cLVwtK1wtXC1c
LVwtXC1cLQotICAgICAwIHwgICAgICB8ICAgICAgfCAgICAgICB8ICAgICAgfAotICAgICAxIHwg
IFggICB8ICAgICAgfCAgICAgICB8ICAgICAgfAotICAgICAyIHwgICAgICB8ICBYICAgfCAgICAg
ICB8ICAgICAgfAotICAgICAzIHwgIFggICB8ICBYICAgfCAgICAgICB8ICAgICAgfAotICAgICA0
IHwgICAgICB8ICBYICAgfCAgWCAgICB8ICAgICAgfAotICAgICA1IHwgIFggICB8ICBYICAgfCAg
WCAgICB8ICAgICAgfAotICAgICA2IHwgICAgICB8ICBYICAgfCAgWCAgICB8ICAgICAgfAotICAg
ICA3IHwgIFggICB8ICBYICAgfCAgWCAgICB8ICAgICAgfAotICAgICA4IHwgICAgICB8ICAgICAg
fCAgICAgICB8ICBYICAgfAotICAgICA5IHwgIFggICB8ICAgICAgfCAgICAgICB8ICBYICAgfAot
ICAgIDEwIHwgICAgICB8ICBYICAgfCAgICAgICB8ICBYICAgfAotICAgIDExIHwgIFggICB8ICBY
ICAgfCAgICAgICB8ICBYICAgfAotICAgIDEyIHwgICAgICB8ICBYICAgfCAgWCAgICB8ICBYICAg
fAotICAgIDEzIHwgIFggICB8ICBYICAgfCAgWCAgICB8ICBYICAgfAotICAgIDE0IHwgICAgICB8
ICBYICAgfCAgWCAgICB8ICBYICAgfAotICAgIDE1IHwgIFggICB8ICBYICAgfCAgWCAgICB8ICBY
ICAgfAotICAgIDE2IHwgICAgICB8ICAgICAgfCAgICAgICB8ICAgICAgfCAgWAotICAgIDE3IHwg
IFggICB8ICAgICAgfCAgICAgICB8ICAgICAgfCAgWAotICAgIDE4IHwgICAgICB8ICBYICAgfCAg
ICAgICB8ICAgICAgfCAgWAotICAgIDE5IHwgIFggICB8ICBYICAgfCAgICAgICB8ICAgICAgfCAg
WAotICAgIDIwIHwgICAgICB8ICBYICAgfCAgWCAgICB8ICAgICAgfCAgWAotICAgIDIxIHwgIFgg
ICB8ICBYICAgfCAgWCAgICB8ICAgICAgfCAgWAotICAgIDIyIHwgICAgICB8ICBYICAgfCAgWCAg
ICB8ICAgICAgfCAgWAotICAgIDIzIHwgIFggICB8ICBYICAgfCAgWCAgICB8ICAgICAgfCAgWAot
ICAgIDI0IHwgICAgICB8ICAgICAgfCAgICAgICB8ICBYICAgfCAgWAotICAgIDI1IHwgIFggICB8
ICAgICAgfCAgICAgICB8ICBYICAgfCAgWAotICAgIDI2IHwgICAgICB8ICBYICAgfCAgICAgICB8
ICBYICAgfCAgWAotICAgIDI3IHwgIFggICB8ICBYICAgfCAgICAgICB8ICBYICAgfCAgWAotICAg
IDI4IHwgICAgICB8ICBYICAgfCAgWCAgICB8ICBYICAgfCAgWAotICAgIDI5IHwgIFggICB8ICBY
ICAgfCAgWCAgICB8ICBYICAgfCAgWAotICAgIDMwIHwgICAgICB8ICBYICAgfCAgWCAgICB8ICBY
ICAgfCAgWAotICAgIDMxIHwgIFggICB8ICBYICAgfCAgWCAgICB8ICBYICAgfCAgWAorICAgICAw
IHwgICAgICB8ICAgICAgICAgICAgICB8ICAgICAgICAgICAgICB8ICAgICAgfAorICAgICAxIHwg
IFggICB8ICAgICAgICAgICAgICB8ICAgICAgICAgICAgICB8ICAgICAgfAorICAgICAyIHwgICAg
ICB8ICAgICAgICAgICAgICB8ICBYICAgICAgICAgICB8ICAgICAgfAorICAgICAzIHwgIFggICB8
ICAgICAgICAgICAgICB8ICBYICAgICAgICAgICB8ICAgICAgfAorICAgICA0IHwgICAgICB8ICBY
ICAgICAgICAgICB8ICBYICAgICAgICAgICB8ICAgICAgfAorICAgICA1IHwgIFggICB8ICBYICAg
ICAgICAgICB8ICBYICAgICAgICAgICB8ICAgICAgfAorICAgICA2IHwgICAgICB8ICBYICAgICAg
ICAgICB8ICBYICAgICAgICAgICB8ICAgICAgfAorICAgICA3IHwgIFggICB8ICBYICAgICAgICAg
ICB8ICBYICAgICAgICAgICB8ICAgICAgfAorICAgICA4IHwgICAgICB8ICAgICAgICAgICAgICB8
ICAgICAgICAgICAgICB8ICBYICAgfAorICAgICA5IHwgIFggICB8ICAgICAgICAgICAgICB8ICAg
ICAgICAgICAgICB8ICBYICAgfAorICAgIDEwIHwgICAgICB8ICAgICAgICAgICAgICB8ICBYICAg
ICAgICAgICB8ICBYICAgfAorICAgIDExIHwgIFggICB8ICAgICAgICAgICAgICB8ICBYICAgICAg
ICAgICB8ICBYICAgfAorICAgIDEyIHwgICAgICB8ICBYICAgICAgICAgICB8ICBYICAgICAgICAg
ICB8ICBYICAgfAorICAgIDEzIHwgIFggICB8ICBYICAgICAgICAgICB8ICBYICAgICAgICAgICB8
ICBYICAgfAorICAgIDE0IHwgICAgICB8ICBYICAgICAgICAgICB8ICBYICAgICAgICAgICB8ICBY
ICAgfAorICAgIDE1IHwgIFggICB8ICBYICAgICAgICAgICB8ICBYICAgICAgICAgICB8ICBYICAg
fAorICAgIDE2IHwgICAgICB8ICAgICAgICAgICAgICB8ICAgICAgICAgICAgICB8ICAgICAgfCAg
WAorICAgIDE3IHwgIFggICB8ICAgICAgICAgICAgICB8ICAgICAgICAgICAgICB8ICAgICAgfCAg
WAorICAgIDE4IHwgICAgICB8ICAgICAgICAgICAgICB8ICBYICAgICAgICAgICB8ICAgICAgfCAg
WAorICAgIDE5IHwgIFggICB8ICAgICAgICAgICAgICB8ICBYICAgICAgICAgICB8ICAgICAgfCAg
WAorICAgIDIwIHwgICAgICB8ICBYICAgICAgICAgICB8ICBYICAgICAgICAgICB8ICAgICAgfCAg
WAorICAgIDIxIHwgIFggICB8ICBYICAgICAgICAgICB8ICBYICAgICAgICAgICB8ICAgICAgfCAg
WAorICAgIDIyIHwgICAgICB8ICBYICAgICAgICAgICB8ICBYICAgICAgICAgICB8ICAgICAgfCAg
WAorICAgIDIzIHwgIFggICB8ICBYICAgICAgICAgICB8ICBYICAgICAgICAgICB8ICAgICAgfCAg
WAorICAgIDI0IHwgICAgICB8ICAgICAgICAgICAgICB8ICAgICAgICAgICAgICB8ICBYICAgfCAg
WAorICAgIDI1IHwgIFggICB8ICAgICAgICAgICAgICB8ICAgICAgICAgICAgICB8ICBYICAgfCAg
WAorICAgIDI2IHwgICAgICB8ICAgICAgICAgICAgICB8ICBYICAgICAgICAgICB8ICBYICAgfCAg
WAorICAgIDI3IHwgIFggICB8ICAgICAgICAgICAgICB8ICBYICAgICAgICAgICB8ICBYICAgfCAg
WAorICAgIDI4IHwgICAgICB8ICBYICAgICAgICAgICB8ICBYICAgICAgICAgICB8ICBYICAgfCAg
WAorICAgIDI5IHwgIFggICB8ICBYICAgICAgICAgICB8ICBYICAgICAgICAgICB8ICBYICAgfCAg
WAorICAgIDMwIHwgICAgICB8ICBYICAgICAgICAgICB8ICBYICAgICAgICAgICB8ICBYICAgfCAg
WAorICAgIDMxIHwgIFggICB8ICBYICAgICAgICAgICB8ICBYICAgICAgICAgICB8ICBYICAgfCAg
WAogCiAKIC5UUAo=
--00504502d1266a714804a8e81a84
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--00504502d1266a714804a8e81a84--

