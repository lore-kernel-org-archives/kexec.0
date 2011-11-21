Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-iy0-f177.google.com ([209.85.210.177])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RSOXP-0002of-Qf
 for kexec@lists.infradead.org; Mon, 21 Nov 2011 07:43:36 +0000
Received: by iapp10 with SMTP id p10so8897959iap.36
 for <kexec@lists.infradead.org>; Sun, 20 Nov 2011 23:43:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20111118021155.GM14082@verge.net.au>
References: <1321448966-25163-1-git-send-email-xiyou.wangcong@gmail.com>
 <20111118021155.GM14082@verge.net.au>
Date: Mon, 21 Nov 2011 15:43:34 +0800
Message-ID: <CAM_iQpUFSHrEy9z902iMucEN5EisxdjO=QYtJGkF=f1m6qnAKg@mail.gmail.com>
Subject: Re: [Patch] kexec: fix several issues in get_crash_notes()
From: Cong Wang <xiyou.wangcong@gmail.com>
Content-Type: multipart/mixed; boundary=0015176f03b009b58704b239d8fe
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org

--0015176f03b009b58704b239d8fe
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 18, 2011 at 10:11 AM, Simon Horman <horms@verge.net.au> wrote:
> On Wed, Nov 16, 2011 at 09:09:26PM +0800, WANG Cong wrote:
>> a) We don't need 'crash_notes' array at all, save some bytes on stack.
>> b) We forgot to fclose 'fp' before return.
>>
>> Signed-off-by: WANG Cong <xiyou.wangcong@gmail.com>
>>
>> ---
>> diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump=
-x86.c
>> index 98cda72..333f6ba 100644
>> --- a/kexec/arch/i386/crashdump-x86.c
>> +++ b/kexec/arch/i386/crashdump-x86.c
>> @@ -589,20 +589,18 @@ static int cmdline_add_elfcorehdr(char *cmdline, u=
nsigned long addr)
>> =C2=A0 */
>> =C2=A0static int get_crash_notes(int cpu, uint64_t *addr, uint64_t *len)
>> =C2=A0{
>> - =C2=A0 =C2=A0 char crash_notes[PATH_MAX];
>
> I wonder if the following might reduce memory usage:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *crash_notes =3D "/sys/kernel/crash=
_notes";

Yeah, sure. Below is the new patch.
-------------------->

a) We don't need 'crash_notes' array at all, save some bytes on stack.
b) We forgot to fclose 'fp' before return.

Signed-off-by: WANG Cong <xiyou.wangcong@gmail.com>
---

--0015176f03b009b58704b239d8fe
Content-Type: text/x-patch; charset=US-ASCII; name="kexec-tools-fix-get_crash_notes.diff"
Content-Disposition: attachment; 
	filename="kexec-tools-fix-get_crash_notes.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gv965dtg0

ZGlmZiAtLWdpdCBhL2tleGVjL2FyY2gvaTM4Ni9jcmFzaGR1bXAteDg2LmMgYi9rZXhlYy9hcmNo
L2kzODYvY3Jhc2hkdW1wLXg4Ni5jCmluZGV4IDk4Y2RhNzIuLjQzNjc5N2EgMTAwNjQ0Ci0tLSBh
L2tleGVjL2FyY2gvaTM4Ni9jcmFzaGR1bXAteDg2LmMKKysrIGIva2V4ZWMvYXJjaC9pMzg2L2Ny
YXNoZHVtcC14ODYuYwpAQCAtNTg5LDEzICs1ODksMTIgQEAgc3RhdGljIGludCBjbWRsaW5lX2Fk
ZF9lbGZjb3JlaGRyKGNoYXIgKmNtZGxpbmUsIHVuc2lnbmVkIGxvbmcgYWRkcikKICAqLwogc3Rh
dGljIGludCBnZXRfY3Jhc2hfbm90ZXMoaW50IGNwdSwgdWludDY0X3QgKmFkZHIsIHVpbnQ2NF90
ICpsZW4pCiB7Ci0JY2hhciBjcmFzaF9ub3Rlc1tQQVRIX01BWF07CisJY29uc3QgY2hhciAqY3Jh
c2hfbm90ZXMgPSAiL3N5cy9rZXJuZWwvY3Jhc2hfbm90ZXMiOwogCWNoYXIgbGluZVtNQVhfTElO
RV07CiAJRklMRSAqZnA7CiAJdW5zaWduZWQgbG9uZyB2YWRkcjsKIAlpbnQgY291bnQ7CiAKLQlz
cHJpbnRmKGNyYXNoX25vdGVzLCAiL3N5cy9rZXJuZWwvY3Jhc2hfbm90ZXMiKTsKIAlmcCA9IGZv
cGVuKGNyYXNoX25vdGVzLCAiciIpOwogCWlmIChmcCkgewogCQlpZiAoZmdldHMobGluZSwgc2l6
ZW9mKGxpbmUpLCBmcCkgIT0gMCkgewpAQCAtNjEwLDYgKzYwOSw3IEBAIHN0YXRpYyBpbnQgZ2V0
X2NyYXNoX25vdGVzKGludCBjcHUsIHVpbnQ2NF90ICphZGRyLCB1aW50NjRfdCAqbGVuKQogI2lm
ZGVmIERFQlVHCiAJCXByaW50ZigiY3Jhc2hfbm90ZXMgYWRkciA9ICVMeFxuIiwgKmFkZHIpOwog
I2VuZGlmCisJCWZjbG9zZShmcCk7CiAJCXJldHVybiAwOwogCX0gZWxzZQogCQlyZXR1cm4gZ2V0
X2NyYXNoX25vdGVzX3Blcl9jcHUoY3B1LCBhZGRyLCBsZW4pOwo=
--0015176f03b009b58704b239d8fe
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--0015176f03b009b58704b239d8fe--

