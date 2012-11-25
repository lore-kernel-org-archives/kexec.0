Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bk0-f49.google.com ([209.85.214.49])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TcQDt-0001FA-4y
 for kexec@lists.infradead.org; Sun, 25 Nov 2012 00:37:28 +0000
Received: by mail-bk0-f49.google.com with SMTP id jm19so2940323bkc.36
 for <kexec@lists.infradead.org>; Sat, 24 Nov 2012 16:37:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1353790066-20352-5-git-send-email-yinghai@kernel.org>
References: <1353790066-20352-1-git-send-email-yinghai@kernel.org>
 <1353790066-20352-5-git-send-email-yinghai@kernel.org>
Date: Sat, 24 Nov 2012 16:37:19 -0800
Message-ID: <CAE9FiQWZ-uZZiQnRWcEu54+q7JXoQE5Tx+zPZEm0Phx2ZyDX=A@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] kexec, x86: put ramdisk high for 64bit bzImage
From: Yinghai Lu <yinghai@kernel.org>
Content-Type: multipart/mixed; boundary=0015174c33d6fef84504cf4704c8
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
To: Simon Horman <horms@verge.net.au>, "H. Peter Anvin" <hpa@zytor.com>, Vivek Goyal <vgoyal@redhat.com>, Haren Myneni <hbabu@us.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Yinghai Lu <yinghai@kernel.org>, kexec@lists.infradead.org

--0015174c33d6fef84504cf4704c8
Content-Type: text/plain; charset=ISO-8859-1

On Sat, Nov 24, 2012 at 12:47 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> We could put ramdisk high for bzImage on 64bit for protocol 2.12.
>
> -v2: change ext_... handling to way that eric like.

-v5 attached

--0015174c33d6fef84504cf4704c8
Content-Type: application/octet-stream; 
	name="ramdisk_high_mem_64_x_6_v5.patch"
Content-Disposition: attachment; filename="ramdisk_high_mem_64_x_6_v5.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h9xfumot0

U3ViamVjdDogW1BBVENIIHY1IDQvNl0ga2V4ZWMsIHg4NjogcHV0IHJhbWRpc2sgaGlnaCBmb3Ig
NjRiaXQgYnpJbWFnZQoKV2UgY291bGQgcHV0IHJhbWRpc2sgaGlnaCBmb3IgYnpJbWFnZSBvbiA2
NGJpdCBmb3IgcHJvdG9jb2wgMi4xMi4KCi12MjogY2hhbmdlIGV4dF8uLi4gaGFuZGxpbmcgdG8g
d2F5IHRoYXQgZXJpYyBsaWtlLgoKU2lnbmVkLW9mZi1ieTogWWluZ2hhaSBMdSA8eWluZ2hhaUBr
ZXJuZWwub3JnPgoKLS0tCiBrZXhlYy9hcmNoL2kzODYveDg2LWxpbnV4LXNldHVwLmMgfCAgIDE4
ICsrKysrKysrKysrKysrKy0tLQogMSBmaWxlIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDMg
ZGVsZXRpb25zKC0pCgpJbmRleDoga2V4ZWMtdG9vbHMva2V4ZWMvYXJjaC9pMzg2L3g4Ni1saW51
eC1zZXR1cC5jCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT0KLS0tIGtleGVjLXRvb2xzLm9yaWcva2V4ZWMvYXJjaC9pMzg2
L3g4Ni1saW51eC1zZXR1cC5jCisrKyBrZXhlYy10b29scy9rZXhlYy9hcmNoL2kzODYveDg2LWxp
bnV4LXNldHVwLmMKQEAgLTY0LDcgKzY0LDExIEBAIHZvaWQgc2V0dXBfbGludXhfYm9vdGxvYWRl
cl9wYXJhbWV0ZXJzKAogCS8qIEZpbmQgdGhlIG1heGltdW0gaW5pdGlhbCByYW1kaXNrIGFkZHJl
c3MgKi8KIAlpbml0cmRfYWRkcl9tYXggPSBERUZBVUxUX0lOSVRSRF9BRERSX01BWDsKIAlpZiAo
cmVhbF9tb2RlLT5wcm90b2NvbF92ZXJzaW9uID49IDB4MDIwMykgewotCQlpbml0cmRfYWRkcl9t
YXggPSByZWFsX21vZGUtPmluaXRyZF9hZGRyX21heDsKKwkJaWYgKHJlYWxfbW9kZS0+cHJvdG9j
b2xfdmVyc2lvbiA+PSAweDAyMGMgJiYKKwkJICAgIHJlYWxfbW9kZS0+eGxvYWRmbGFncyAmICgx
PDwxNSkpIC8qIFVTRV9FWFRfQk9PVF9QQVJBTVMgKi8KKwkJCWluaXRyZF9hZGRyX21heCA9IFVM
T05HX01BWDsKKwkJZWxzZQorCQkJaW5pdHJkX2FkZHJfbWF4ID0gcmVhbF9tb2RlLT5pbml0cmRf
YWRkcl9tYXg7CiAJCWRiZ3ByaW50ZigiaW5pdHJkX2FkZHJfbWF4IGlzIDB4JWx4XG4iLCBpbml0
cmRfYWRkcl9tYXgpOwogCX0KIApAQCAtODEsOCArODUsMTYgQEAgdm9pZCBzZXR1cF9saW51eF9i
b290bG9hZGVyX3BhcmFtZXRlcnMoCiAJfQogCiAJLyogUmFtZGlzayBhZGRyZXNzIGFuZCBzaXpl
ICovCi0JcmVhbF9tb2RlLT5pbml0cmRfc3RhcnQgPSBpbml0cmRfYmFzZTsKLQlyZWFsX21vZGUt
PmluaXRyZF9zaXplICA9IGluaXRyZF9zaXplOworCXJlYWxfbW9kZS0+aW5pdHJkX3N0YXJ0ID0g
aW5pdHJkX2Jhc2UgJiAweGZmZmZmZmZmVUw7CisJcmVhbF9tb2RlLT5pbml0cmRfc2l6ZSAgPSBp
bml0cmRfc2l6ZSAmIDB4ZmZmZmZmZmZVTDsKKworCWlmIChyZWFsX21vZGUtPnByb3RvY29sX3Zl
cnNpb24gPj0gMHgwMjBjICYmCisJICAgIChpbml0cmRfYmFzZSAmIDB4ZmZmZmZmZmZVTCkgIT0g
aW5pdHJkX2Jhc2UpCisJCXJlYWxfbW9kZS0+ZXh0X3JhbWRpc2tfaW1hZ2UgPSBpbml0cmRfYmFz
ZSA+PiAzMjsKKworCWlmIChyZWFsX21vZGUtPnByb3RvY29sX3ZlcnNpb24gPj0gMHgwMjBjICYm
CisJICAgIChpbml0cmRfc2l6ZSAmIDB4ZmZmZmZmZmZVTCkgIT0gaW5pdHJkX3NpemUpCisJCXJl
YWxfbW9kZS0+ZXh0X3JhbWRpc2tfc2l6ZSA9IGluaXRyZF9zaXplID4+IDMyOwogCiAJLyogVGhl
IGxvY2F0aW9uIG9mIHRoZSBjb21tYW5kIGxpbmUgKi8KIAkvKiBpZiAocmVhbF9tb2RlX2Jhc2Ug
PT0gMHg5MDAwMCkgeyAqLwo=
--0015174c33d6fef84504cf4704c8
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--0015174c33d6fef84504cf4704c8--

