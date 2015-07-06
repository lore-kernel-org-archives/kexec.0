Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZC6Mp-00079n-U9
 for kexec@lists.infradead.org; Mon, 06 Jul 2015 13:23:29 +0000
Message-ID: <559A8051.5090905@cn.fujitsu.com>
Date: Mon, 6 Jul 2015 21:19:13 +0800
From: =?UTF-8?B?Ilpob3UsIFdlbmppYW4v5ZGo5paH5YmRIg==?=
 <zhouwj-fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 00/10] makedumpfile: parallel processing
References: <1434704204-2634-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
 <558B6696.4020906@cn.fujitsu.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701DC9C14@BPXM01GP.gisp.nec.co.jp>
 <558CFEED.1040501@cn.fujitsu.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701DC9CF3@BPXM01GP.gisp.nec.co.jp>
 <5590E366.6020904@cn.fujitsu.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701DCAB4E@BPXM01GP.gisp.nec.co.jp>
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9701DCAB4E@BPXM01GP.gisp.nec.co.jp>
Content-Type: multipart/mixed; boundary="------------030401080106040306010902"
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

--------------030401080106040306010902
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

Hello Atsushi Kumagai,

I have tried a lot, and I think the big performance degradation only
occurs in special CPU.
I thought about two reasons, and I need your help to confirm which is
the real one.

The following tests will also be OK by using dumpfile instead of /proc/vmcore

Test 1: distinguish whether it is resulted by multi-threads.
apply patch: test1
command1: ./makedumpfile -c /proc/vmcore vmcore --num-threads 1
command2: ./makedumpfile -c /proc/vmcore vmcore --num-threads 8

better to do some test in -l too.
command1: ./makedumpfile -l /proc/vmcore vmcore
command2: ./makedumpfile -l /proc/vmcore vmcore --num-threads 1
command3: ./makedumpfile -l /proc/vmcore vmcore --num-threads 8

Test 2: distinguish whether it is resulted by doing compress in thread
2.1:
	apply patch: test2.1
	command: ./makedumpfile -c /proc/vmcore vmcore --num-threads 1
2.2:
	apply patch: test2.2
	command: ./makedumpfile -c /proc/vmcore vmcore --num-threads 1

Thanks a lot.

BTW, could you show me the cpu name, zlib version and glibc version ?

-- 
Thanks
Zhou Wenjian

On 06/30/2015 05:06 PM, Atsushi Kumagai wrote:
>> On 06/26/2015 03:49 PM, Atsushi Kumagai wrote:
>>> I attached 5 processors to the VM and I confirmed that all threads
>>> consumed full cpu time by top(1) on the host:
>>>
>>>       PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
>>>     17614 qemu      20   0 5792m 4.9g 5652 R 435.1 72.8  29:02.17 qemu-kvm
>>>
>>> So I think the performance must be improved...
>>
>> Since I can't get that result in all machines here, could you test it with the patch:time
>> and show me the output?
>> Using "./makedumpfile -c --num-threads 4 /proc/vmcore dumpfile" is OK.
>>
>> The attachment is the patch time.
>
> Here is the result:
>
> / # makedumpfile -c --num-threads 4 /proc/vmcore /mnt/dumpfile
> Copying data                       : [100.0 %] |
> Copying data                       : [100.0 %] \
>
> The dumpfile is saved to /mnt/dumpfile.
>
> makedumpfile Completed.
> lock time: 310s935500us
> write time: 3s970037us
> hit time: 6s316043us
> find time: 317s926654us
> loop_time: 37s321800us
> thread consume_time: 0s0us
> thread timea: 0s0us
> thread timeb: 0s0us
> read_time[0]: 8s637011us
> lock_current_time[0]: 0s284428us
> found_time[0]: 60s366795us
> lock_consumed_time[0]: 2s782596us
> compress_time[0]: 301s427073us
> read_time[1]: 8s435914us
> lock_current_time[1]: 0s271680us
> found_time[1]: 60s329026us
> lock_consumed_time[1]: 2s849061us
> compress_time[1]: 302s98620us
> read_time[2]: 8s380550us
> lock_current_time[2]: 0s270388us
> found_time[2]: 60s209376us
> lock_consumed_time[2]: 3s297574us
> compress_time[2]: 301s486768us
> read_time[3]: 8s550662us
> lock_current_time[3]: 0s278997us
> found_time[3]: 60s476702us
> lock_consumed_time[3]: 3s49184us
> compress_time[3]: 301s718390us
> count1: 172
> count2: 70921401
> count3: 0
> count4: 0
> count5: 0
> count6: 0
> count7: 0
> exec time: 380s125494us
>
>
> BTW, I fixed a small mistake before testing like:
>
> - write_time = (write2.tv_sec - write1.tv_sec) * 1000000 + (write2.tv_usec - write1.tv_usec);
> + write_time += (write2.tv_sec - write1.tv_sec) * 1000000 + (write2.tv_usec - write1.tv_usec);
>

--------------030401080106040306010902
Content-Type: text/plain; name="test1"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="test1"

LS0tIG1ha2VkdW1wZmlsZS5vcmkJMjAxNS0wNy0wNiAxMTo1NjoxMS4zMDAwMDAwMDAgLTA0
MDAKKysrIG1ha2VkdW1wZmlsZS5jCTIwMTUtMDctMDYgMTE6NTY6MjguMTI3MDAwMDAwIC0w
NDAwCkBAIC0yNiw2ICsyNiw0MiBAQAogI2luY2x1ZGUgPGxpbWl0cy5oPgogI2luY2x1ZGUg
PGFzc2VydC5oPgogCit1bnNpZ25lZCBsb25nIHdyaXRlX2tkdW1wX3BhZ2VzX3BhcmFsbGVs
X2N5Y2xpY190aW1lID0gMDsKK3N0cnVjdCB0aW1ldmFsIHdyaXRlX2tkdW1wX3BhZ2VzX3Bh
cmFsbGVsX2N5Y2xpYzEsIHdyaXRlX2tkdW1wX3BhZ2VzX3BhcmFsbGVsX2N5Y2xpYzI7Cit1
bnNpZ25lZCBsb25nIGxvb3BfdGltZSA9IDA7Cit1bnNpZ25lZCBsb25nIGNvbnN1bWVfdGlt
ZSA9IDA7CitzdHJ1Y3QgdGltZXZhbCBsb29wMSwgbG9vcDI7Cit1bnNpZ25lZCBsb25nIGNo
ZWNrX3RpbWUgPSAwOworc3RydWN0IHRpbWV2YWwgY2hlY2sxLCBjaGVjazI7CitzdHJ1Y3Qg
dGltZXZhbCB3cml0ZTEsIHdyaXRlMjsKK3Vuc2lnbmVkIGxvbmcgd3JpdGVfdGltZTsKK3N0
cnVjdCB0aW1ldmFsIGxvY2sxLCBsb2NrMjsKK3Vuc2lnbmVkIGxvbmcgbG9ja190aW1lOwor
c3RydWN0IHRpbWV2YWwgaGl0MSwgaGl0MjsKK3Vuc2lnbmVkIGxvbmcgaGl0X3RpbWU7Citz
dHJ1Y3QgdGltZXZhbCBmaW5kMSwgZmluZDI7Cit1bnNpZ25lZCBsb25nIGZpbmRfdGltZTsK
K3N0cnVjdCB0aW1ldmFsIHRpbWVhMSwgdGltZWEyOwordW5zaWduZWQgbG9uZyB0aW1lYTsK
K3N0cnVjdCB0aW1ldmFsIHRpbWViMSwgdGltZWIyOwordW5zaWduZWQgbG9uZyBmaWx0ZXJf
dGltZVsyMF07CitzdHJ1Y3QgdGltZXZhbCBmaWx0ZXIxWzIwXSwgZmlsdGVyMlsyMF07Cit1
bnNpZ25lZCBsb25nIGNwX3RpbWVbMjBdOworc3RydWN0IHRpbWV2YWwgY3AxWzIwXSwgY3Ay
WzIwXTsKK3Vuc2lnbmVkIGxvbmcgY29tcHJlc3NfdGltZVsyMF07CitzdHJ1Y3QgdGltZXZh
bCBjb21wcmVzc190aW1lMVsyMF0sIGNvbXByZXNzX3RpbWUyWzIwXTsKK3Vuc2lnbmVkIGxv
bmcgdGltZWI7Cit1bnNpZ25lZCBsb25nIGNvdW50MSA9IDA7Cit1bnNpZ25lZCBsb25nIGNv
dW50MiA9IDA7Cit1bnNpZ25lZCBsb25nIGNvdW50MyA9IDA7Cit1bnNpZ25lZCBsb25nIGNv
dW50NCA9IDA7Cit1bnNpZ25lZCBsb25nIGNvdW50NSA9IDA7Cit1bnNpZ25lZCBsb25nIGNv
dW50NiA9IDA7Cit1bnNpZ25lZCBsb25nIGNvdW50NyA9IDA7Cit1bnNpZ25lZCBsb25nIGNv
dW50OCA9IDA7Cit1bnNpZ25lZCBsb25nIGNvdW50OSA9IDA7CisKKwogc3RydWN0IHN5bWJv
bF90YWJsZQlzeW1ib2xfdGFibGU7CiBzdHJ1Y3Qgc2l6ZV90YWJsZQlzaXplX3RhYmxlOwog
c3RydWN0IG9mZnNldF90YWJsZQlvZmZzZXRfdGFibGU7CkBAIC02OTE5LDYgKzY5NTUsMTcg
QEAKIAlyZXR1cm4gVFJVRTsKIH0KIAoraW50IGNvbXByZXNzMjAxNSh1bnNpZ25lZCBjaGFy
ICpidWZfb3V0LCB1bnNpZ25lZCBsb25nICpzaXplX291dCwgdW5zaWduZWQgY2hhciAqYnVm
LCBpbnQgcGFnZV9zaXplLCBpbnQgYSwgaW50IHRocmVhZF9udW0pCit7CitpbnQgcmV0Owor
Z2V0dGltZW9mZGF5KCZjb21wcmVzc190aW1lMVt0aHJlYWRfbnVtXSwgTlVMTCk7CityZXQg
PSBjb21wcmVzczIoYnVmX291dCwgc2l6ZV9vdXQsIGJ1ZiwgaW5mby0+cGFnZV9zaXplLCBa
X0JFU1RfU1BFRUQpOworZ2V0dGltZW9mZGF5KCZjb21wcmVzc190aW1lMlt0aHJlYWRfbnVt
XSwgTlVMTCk7Citjb21wcmVzc190aW1lW3RocmVhZF9udW1dICs9IChjb21wcmVzc190aW1l
Mlt0aHJlYWRfbnVtXS50dl9zZWMgLSBjb21wcmVzc190aW1lMVt0aHJlYWRfbnVtXS50dl9z
ZWMpICogMTAwMDAwMCArIChjb21wcmVzc190aW1lMlt0aHJlYWRfbnVtXS50dl91c2VjIC0g
Y29tcHJlc3NfdGltZTFbdGhyZWFkX251bV0udHZfdXNlYyk7CisKK3JldHVybiByZXQ7Cit9
CisKIHZvaWQgKgoga2R1bXBfdGhyZWFkX2Z1bmN0aW9uX2N5Y2xpYyh2b2lkICphcmcpIHsK
IAl2b2lkICpyZXR2YWwgPSBQVEhSRUFEX0ZBSUw7CkBAIC02OTQ0LDYgKzY5OTEsNyBAQAog
CXVuc2lnbmVkIGxvbmcgbGVuX2J1Zl9vdXRfc25hcHB5ID0KIAkJCQlzbmFwcHlfbWF4X2Nv
bXByZXNzZWRfbGVuZ3RoKGluZm8tPnBhZ2Vfc2l6ZSk7CiAjZW5kaWYKK2ludCB0aHJlYWRf
bnVtID0ga2R1bXBfdGhyZWFkX2FyZ3MtPnRocmVhZF9udW07CiAKIAlidWYgPSBCVUZfUEFS
QUxMRUwoa2R1bXBfdGhyZWFkX2FyZ3MtPnRocmVhZF9udW0pOwogCWJ1Zl9vdXQgPSBCVUZf
T1VUX1BBUkFMTEVMKGtkdW1wX3RocmVhZF9hcmdzLT50aHJlYWRfbnVtKTsKQEAgLTcwMzAs
OSArNzA3OCwxMyBAQAogCQkJCQkgICAgICAgbW1hcF9jYWNoZSkpCiAJCQkJCWdvdG8gZmFp
bDsKIAorCitnZXR0aW1lb2ZkYXkoJmZpbHRlcjFbdGhyZWFkX251bV0sIE5VTEwpOwogCQkJ
ZmlsdGVyX2RhdGFfYnVmZmVyX3BhcmFsbGVsKGJ1ZiwgcGZuX3RvX3BhZGRyKHBmbiksCiAJ
CQkJCQkJaW5mby0+cGFnZV9zaXplLAogCQkJCQkJCSZpbmZvLT5maWx0ZXJfbXV0ZXgpOwor
Z2V0dGltZW9mZGF5KCZmaWx0ZXIyW3RocmVhZF9udW1dLCBOVUxMKTsKK2ZpbHRlcl90aW1l
W3RocmVhZF9udW1dICs9IChmaWx0ZXIyW3RocmVhZF9udW1dLnR2X3NlYyAtIGZpbHRlcjFb
dGhyZWFkX251bV0udHZfc2VjKSAqIDEwMDAwMDAgKyAoZmlsdGVyMlt0aHJlYWRfbnVtXS50
dl91c2VjIC0gZmlsdGVyMVt0aHJlYWRfbnVtXS50dl91c2VjKTsKIAogCQkJaWYgKChpbmZv
LT5kdW1wX2xldmVsICYgRExfRVhDTFVERV9aRVJPKQogCQkJICAgICYmIGlzX3plcm9fcGFn
ZShidWYsIGluZm8tPnBhZ2Vfc2l6ZSkpIHsKQEAgLTcwNDgsMTQgKzcxMDAsMTcgQEAKIAkJ
CXNpemVfb3V0ID0ga2R1bXBfdGhyZWFkX2FyZ3MtPmxlbl9idWZfb3V0OwogCQkJaWYgKChp
bmZvLT5mbGFnX2NvbXByZXNzICYgRFVNUF9ESF9DT01QUkVTU0VEX1pMSUIpCiAJCQkgICAg
JiYgKChzaXplX291dCA9IGtkdW1wX3RocmVhZF9hcmdzLT5sZW5fYnVmX291dCksCi0JCQkJ
Y29tcHJlc3MyKGJ1Zl9vdXQsICZzaXplX291dCwgYnVmLAorCQkJCWNvbXByZXNzMjAxNShi
dWZfb3V0LCAmc2l6ZV9vdXQsIGJ1ZiwKIAkJCQkJICBpbmZvLT5wYWdlX3NpemUsCi0JCQkJ
CSAgWl9CRVNUX1NQRUVEKSA9PSBaX09LKQorCQkJCQkgIFpfQkVTVF9TUEVFRCwgdGhyZWFk
X251bSkgPT0gWl9PSykKIAkJCSAgICAmJiAoc2l6ZV9vdXQgPCBpbmZvLT5wYWdlX3NpemUp
KSB7CiAJCQkJcGFnZV9kYXRhX2J1ZltpbmRleF0uZmxhZ3MgPQogCQkJCQkJCURVTVBfREhf
Q09NUFJFU1NFRF9aTElCOwogCQkJCXBhZ2VfZGF0YV9idWZbaW5kZXhdLnNpemUgID0gc2l6
ZV9vdXQ7CitnZXR0aW1lb2ZkYXkoJmNwMVt0aHJlYWRfbnVtXSwgTlVMTCk7CiAJCQkJbWVt
Y3B5KHBhZ2VfZGF0YV9idWZbaW5kZXhdLmJ1ZiwgYnVmX291dCwgc2l6ZV9vdXQpOworZ2V0
dGltZW9mZGF5KCZjcDJbdGhyZWFkX251bV0sIE5VTEwpOworY3BfdGltZVt0aHJlYWRfbnVt
XSArPSAoY3AyW3RocmVhZF9udW1dLnR2X3NlYyAtIGNwMVt0aHJlYWRfbnVtXS50dl9zZWMp
ICogMTAwMDAwMCArIChjcDJbdGhyZWFkX251bV0udHZfdXNlYyAtIGNwMVt0aHJlYWRfbnVt
XS50dl91c2VjKTsKICNpZmRlZiBVU0VMWk8KIAkJCX0gZWxzZSBpZiAoaW5mby0+ZmxhZ19s
em9fc3VwcG9ydAogCQkJCSAgICYmIChpbmZvLT5mbGFnX2NvbXByZXNzCkBAIC03MjIwLDYg
KzcyNzUsNyBAQAogCWdldHRpbWVvZmRheSgmbGFzdCwgTlVMTCk7CiAKIAl3aGlsZSAoY29u
c3VtaW5nX3BmbiA8IGVuZF9wZm4pIHsKK2dldHRpbWVvZmRheSgmbG9vcDEsIE5VTEwpOwog
CQlpbmRleCA9IGNvbnN1bWluZ19wZm4gJSBwYWdlX2RhdGFfbnVtOwogCiAJCWdldHRpbWVv
ZmRheSgmbmV3LCBOVUxMKTsKQEAgLTcyMzIsMTcgKzcyODgsMjYgQEAKIAkJICogY2hlY2sg
cGZuIGZpcnN0IHdpdGhvdXQgbXV0ZXggbG9ja2VkIHRvIHJlZHVjZSB0aGUgdGltZQogCQkg
KiB0cnlpbmcgdG8gbG9jayB0aGUgbXV0ZXgKIAkJICovCi0JCWlmIChwYWdlX2RhdGFfYnVm
W2luZGV4XS5wZm4gIT0gY29uc3VtaW5nX3BmbikKKwkJaWYgKHBhZ2VfZGF0YV9idWZbaW5k
ZXhdLnBmbiAhPSBjb25zdW1pbmdfcGZuKXsKK2dldHRpbWVvZmRheSgmbG9vcDIsIE5VTEwp
OworbG9vcF90aW1lICs9IChsb29wMi50dl9zZWMgLSBsb29wMS50dl9zZWMpICogMTAwMDAw
MCArIChsb29wMi50dl91c2VjIC0gbG9vcDEudHZfdXNlYyk7CiAJCQljb250aW51ZTsKK30K
K2dldHRpbWVvZmRheSgmZmluZDEsIE5VTEwpOworZ2V0dGltZW9mZGF5KCZsb2NrMSwgTlVM
TCk7CiAKIAkJcHRocmVhZF9tdXRleF9sb2NrKCZwYWdlX2RhdGFfYnVmW2luZGV4XS5tdXRl
eCk7CiAKK2dldHRpbWVvZmRheSgmbG9jazIsIE5VTEwpOworbG9ja190aW1lICs9IChsb2Nr
Mi50dl9zZWMgLSBsb2NrMS50dl9zZWMpICogMTAwMDAwMCArIChsb2NrMi50dl91c2VjIC0g
bG9jazEudHZfdXNlYyk7CisKIAkJLyogY2hlY2sgd2hldGhlciB0aGUgZm91bmQgb25lIGlz
IHJlYWR5IHRvIGJlIGNvbnN1bWVkICovCiAJCWlmIChwYWdlX2RhdGFfYnVmW2luZGV4XS5w
Zm4gIT0gY29uc3VtaW5nX3BmbiB8fAogCQkgICAgcGFnZV9kYXRhX2J1ZltpbmRleF0ucmVh
ZHkgIT0gMSkgewogCQkJZ290byB1bmxvY2s7CiAJCX0KIAorZ2V0dGltZW9mZGF5KCZoaXQx
LCBOVUxMKTsKIAkJaWYgKChudW1fZHVtcGVkICUgcGVyKSA9PSAwKQogCQkJcHJpbnRfcHJv
Z3Jlc3MoUFJPR1JFU1NfQ09QWSwgbnVtX2R1bXBlZCwgaW5mby0+bnVtX2R1bXBhYmxlKTsK
IApAQCAtNzI1Niw2ICs3MzIxLDcgQEAKIAogCQludW1fZHVtcGVkKys7CiAKK2dldHRpbWVv
ZmRheSgmd3JpdGUxLCBOVUxMKTsKIAkJaWYgKHBhZ2VfZGF0YV9idWZbaW5kZXhdLnplcm8g
PT0gVFJVRSkgewogCQkJaWYgKCF3cml0ZV9jYWNoZShjZF9oZWFkZXIsIHBkX3plcm8sIHNp
emVvZihwYWdlX2Rlc2NfdCkpKQogCQkJCWdvdG8gb3V0OwpAQCAtNzI3OCw4ICs3MzQ0LDE3
IEBACiAJCQkJZ290byBvdXQ7CiAKIAkJfQorCitnZXR0aW1lb2ZkYXkoJndyaXRlMiwgTlVM
TCk7Cit3cml0ZV90aW1lICs9ICh3cml0ZTIudHZfc2VjIC0gd3JpdGUxLnR2X3NlYykgKiAx
MDAwMDAwICsgKHdyaXRlMi50dl91c2VjIC0gd3JpdGUxLnR2X3VzZWMpOworCiB1bmxvY2s6
CiAJCXB0aHJlYWRfbXV0ZXhfdW5sb2NrKCZwYWdlX2RhdGFfYnVmW2luZGV4XS5tdXRleCk7
CitnZXR0aW1lb2ZkYXkoJmhpdDIsIE5VTEwpOworZ2V0dGltZW9mZGF5KCZmaW5kMiwgTlVM
TCk7CitoaXRfdGltZSArPSAoaGl0Mi50dl9zZWMgLSBoaXQxLnR2X3NlYykgKiAxMDAwMDAw
ICsgKGhpdDIudHZfdXNlYyAtIGhpdDEudHZfdXNlYyk7CitmaW5kX3RpbWUgKz0gKGZpbmQy
LnR2X3NlYyAtIGZpbmQxLnR2X3NlYykgKiAxMDAwMDAwICsgKGZpbmQyLnR2X3VzZWMgLSBm
aW5kMS50dl91c2VjKTsKKwogCX0KIAogCXJldCA9IFRSVUU7CkBAIC03NDM4LDggKzc1MTMs
OCBAQAogCQlzaXplX291dCA9IGxlbl9idWZfb3V0OwogCQlpZiAoKGluZm8tPmZsYWdfY29t
cHJlc3MgJiBEVU1QX0RIX0NPTVBSRVNTRURfWkxJQikKIAkJICAgICYmICgoc2l6ZV9vdXQg
PSBsZW5fYnVmX291dCksCi0JCQljb21wcmVzczIoYnVmX291dCwgJnNpemVfb3V0LCBidWYs
IGluZm8tPnBhZ2Vfc2l6ZSwKLQkJCQkgIFpfQkVTVF9TUEVFRCkgPT0gWl9PSykKKwkJCWNv
bXByZXNzMjAxNShidWZfb3V0LCAmc2l6ZV9vdXQsIGJ1ZiwgaW5mby0+cGFnZV9zaXplLAor
CQkJCSAgWl9CRVNUX1NQRUVELCAwKSA9PSBaX09LKQogCQkgICAgJiYgKHNpemVfb3V0IDwg
aW5mby0+cGFnZV9zaXplKSkgewogCQkJcGQuZmxhZ3MgPSBEVU1QX0RIX0NPTVBSRVNTRURf
WkxJQjsKIAkJCXBkLnNpemUgID0gc2l6ZV9vdXQ7CkBAIC0xMDMxNCw2ICsxMDM4OSwxMSBA
QAogaW50CiBtYWluKGludCBhcmdjLCBjaGFyICphcmd2W10pCiB7CisgICAgICAgIHVuc2ln
bmVkIGxvbmcgdG90YWxfdGltZSA9IDA7CisgICAgICAgIHN0cnVjdCB0aW1ldmFsIHN0YXJ0
X3RpbWUsIGVuZF90aW1lOworICAgICAgICBnZXR0aW1lb2ZkYXkoJnN0YXJ0X3RpbWUsIE5V
TEwpOworCisKIAlpbnQgaSwgb3B0LCBmbGFnX2RlYnVnID0gRkFMU0U7CiAKIAlpZiAoKGlu
Zm8gPSBjYWxsb2MoMSwgc2l6ZW9mKHN0cnVjdCBEdW1wSW5mbykpKSA9PSBOVUxMKSB7CkBA
IC0xMDMyOCw3ICsxMDQwOCw2IEBACiAJCWdvdG8gb3V0OwogCX0KIAlpbml0aWFsaXplX3Rh
YmxlcygpOwotCiAJLyoKIAkgKiBCeSBkZWZhdWx0LCBtYWtlZHVtcGZpbGUgYXNzdW1lcyB0
aGF0IG11bHRpLWN5Y2xlIHByb2Nlc3NpbmcgaXMKIAkgKiBuZWNlc3NhcnkgdG8gd29yayBp
biBjb25zdGFudCBtZW1vcnkgc3BhY2UuCkBAIC0xMDY0Miw1ICsxMDcyMSwyMSBAQAogCX0K
IAlmcmVlX2VsZl9pbmZvKCk7CiAKKyAgICAgICAgZ2V0dGltZW9mZGF5KCZlbmRfdGltZSwg
TlVMTCk7CisgICAgICAgIHRvdGFsX3RpbWUgPSAoZW5kX3RpbWUudHZfc2VjIC0gc3RhcnRf
dGltZS50dl9zZWMpICogMTAwMDAwMCArIChlbmRfdGltZS50dl91c2VjIC0gc3RhcnRfdGlt
ZS50dl91c2VjKTsKKyAgICAgICAgTVNHKCJsb2NrIHRpbWU6ICVsZHMlbGR1c1xuIiwgbG9j
a190aW1lIC8gMTAwMDAwMCwgbG9ja190aW1lICUgMTAwMDAwMCk7CisgICAgICAgIE1TRygi
d3JpdGUgdGltZTogJWxkcyVsZHVzXG4iLCB3cml0ZV90aW1lIC8gMTAwMDAwMCwgd3JpdGVf
dGltZSAlIDEwMDAwMDApOworICAgICAgICBNU0coImhpdCB0aW1lOiAlbGRzJWxkdXNcbiIs
IGhpdF90aW1lIC8gMTAwMDAwMCwgaGl0X3RpbWUgJSAxMDAwMDAwKTsKKyAgICAgICAgTVNH
KCJmaW5kIHRpbWU6ICVsZHMlbGR1c1xuIiwgZmluZF90aW1lIC8gMTAwMDAwMCwgZmluZF90
aW1lICUgMTAwMDAwMCk7CisgICAgICAgIE1TRygibG9vcF90aW1lOiAlbGRzJWxkdXNcbiIs
IGxvb3BfdGltZSAvIDEwMDAwMDAsIGxvb3BfdGltZSAlIDEwMDAwMDApOworICAgICAgICBN
U0coInRocmVhZCBjb25zdW1lX3RpbWU6ICVsZHMlbGR1c1xuIiwgY29uc3VtZV90aW1lIC8g
MTAwMDAwMCwgY29uc3VtZV90aW1lICUgMTAwMDAwMCk7Citmb3IgKGkgPSAwOyBpIDwgaW5m
by0+bnVtX3RocmVhZHM7IGkrKyl7CisgICAgICAgIE1TRygiZmlsdGVyX3RpbWVbJWRdOiAl
bGRzJWxkdXNcbiIsIGksICBmaWx0ZXJfdGltZVtpXSAvIDEwMDAwMDAsIGZpbHRlcl90aW1l
W2ldICUgMTAwMDAwMCk7CisgICAgICAgIE1TRygiY3BfdGltZVslZF06ICVsZHMlbGR1c1xu
IiwgaSwgIGNwX3RpbWVbaV0gLyAxMDAwMDAwLCBjcF90aW1lW2ldICUgMTAwMDAwMCk7Cisg
ICAgICAgIE1TRygiY29tcHJlc3NfdGltZVslZF06ICVsZHMlbGR1c1xuIiwgaSwgIGNvbXBy
ZXNzX3RpbWVbaV0gLyAxMDAwMDAwLCBjb21wcmVzc190aW1lW2ldICUgMTAwMDAwMCk7Cit9
CisgICAgICAgIE1TRygiZXhlYyB0aW1lOiAlbGRzJWxkdXNcbiIsIHRvdGFsX3RpbWUgLyAx
MDAwMDAwLCB0b3RhbF90aW1lICUgMTAwMDAwMCk7CisKKwogCXJldHVybiByZXRjZDsKIH0K

--------------030401080106040306010902
Content-Type: application/x-troff-man; name="test2.1"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="test2.1"

--- 11	2015-07-06 12:18:08.023000000 -0400
+++ makedumpfile.c	2015-07-06 12:37:51.194000000 -0400
@@ -26,6 +26,42 @@
 #include <limits.h>
 #include <assert.h>
 
+unsigned long write_kdump_pages_parallel_cyclic_time = 0;
+struct timeval write_kdump_pages_parallel_cyclic1, write_kdump_pages_parallel_cyclic2;
+unsigned long loop_time = 0;
+unsigned long consume_time = 0;
+struct timeval loop1, loop2;
+unsigned long check_time = 0;
+struct timeval check1, check2;
+struct timeval write1, write2;
+unsigned long write_time;
+struct timeval lock1, lock2;
+unsigned long lock_time;
+struct timeval hit1, hit2;
+unsigned long hit_time;
+struct timeval find1, find2;
+unsigned long find_time;
+struct timeval timea1, timea2;
+unsigned long timea;
+struct timeval timeb1, timeb2;
+unsigned long filter_time[20];
+struct timeval filter1[20], filter2[20];
+unsigned long cp_time[20];
+struct timeval cp1[20], cp2[20];
+unsigned long compress_time[20];
+struct timeval compress_time1[20], compress_time2[20];
+unsigned long timeb;
+unsigned long count1 = 0;
+unsigned long count2 = 0;
+unsigned long count3 = 0;
+unsigned long count4 = 0;
+unsigned long count5 = 0;
+unsigned long count6 = 0;
+unsigned long count7 = 0;
+unsigned long count8 = 0;
+unsigned long count9 = 0;
+
+
 struct symbol_table	symbol_table;
 struct size_table	size_table;
 struct offset_table	offset_table;
@@ -6919,6 +6955,17 @@
 	return TRUE;
 }
 
+int compress2015(unsigned char *buf_out, unsigned long *size_out, unsigned char *buf, int page_size, int a, int thread_num)
+{
+int ret;
+gettimeofday(&compress_time1[thread_num], NULL);
+ret = compress2(buf_out, size_out, buf, info->page_size, Z_BEST_SPEED);
+gettimeofday(&compress_time2[thread_num], NULL);
+compress_time[thread_num] += (compress_time2[thread_num].tv_sec - compress_time1[thread_num].tv_sec) * 1000000 + (compress_time2[thread_num].tv_usec - compress_time1[thread_num].tv_usec);
+
+return ret;
+}
+
 void *
 kdump_thread_function_cyclic(void *arg) {
 	void *retval = PTHREAD_FAIL;
@@ -6944,6 +6991,7 @@
 	unsigned long len_buf_out_snappy =
 				snappy_max_compressed_length(info->page_size);
 #endif
+int thread_num = kdump_thread_args->thread_num;
 
 	buf = BUF_PARALLEL(kdump_thread_args->thread_num);
 	buf_out = BUF_OUT_PARALLEL(kdump_thread_args->thread_num);
@@ -6981,6 +7029,8 @@
 			 */
 			sleep(0);
 
+			index = thread_num;
+/*
 			index = pfn % page_data_num;
 
 			if (page_data_buf[index].ready != 0)
@@ -6999,12 +7049,15 @@
 			consumed_pfn = info->consumed_pfn;
 			pthread_mutex_unlock(&info->consumed_pfn_mutex);
 
+*/
 			/*
 			 * leave space for slow producer
 			 */
+/*
 			if ((long)pfn - (long)consumed_pfn > page_data_num)
 				goto unlock;
 
+*/
 			found = TRUE;
 
 			page_data_buf[index].pfn = pfn;
@@ -7030,9 +7083,13 @@
 					       mmap_cache))
 					goto fail;
 
+
+gettimeofday(&filter1[thread_num], NULL);
 			filter_data_buffer_parallel(buf, pfn_to_paddr(pfn),
 							info->page_size,
 							&info->filter_mutex);
+gettimeofday(&filter2[thread_num], NULL);
+filter_time[thread_num] += (filter2[thread_num].tv_sec - filter1[thread_num].tv_sec) * 1000000 + (filter2[thread_num].tv_usec - filter1[thread_num].tv_usec);
 
 			if ((info->dump_level & DL_EXCLUDE_ZERO)
 			    && is_zero_page(buf, info->page_size)) {
@@ -7048,14 +7105,17 @@
 			size_out = kdump_thread_args->len_buf_out;
 			if ((info->flag_compress & DUMP_DH_COMPRESSED_ZLIB)
 			    && ((size_out = kdump_thread_args->len_buf_out),
-				compress2(buf_out, &size_out, buf,
+				compress2015(buf_out, &size_out, buf,
 					  info->page_size,
-					  Z_BEST_SPEED) == Z_OK)
+					  Z_BEST_SPEED, thread_num) == Z_OK)
 			    && (size_out < info->page_size)) {
 				page_data_buf[index].flags =
 							DUMP_DH_COMPRESSED_ZLIB;
 				page_data_buf[index].size  = size_out;
+gettimeofday(&cp1[thread_num], NULL);
 				memcpy(page_data_buf[index].buf, buf_out, size_out);
+gettimeofday(&cp2[thread_num], NULL);
+cp_time[thread_num] += (cp2[thread_num].tv_sec - cp1[thread_num].tv_sec) * 1000000 + (cp2[thread_num].tv_usec - cp1[thread_num].tv_usec);
 #ifdef USELZO
 			} else if (info->flag_lzo_support
 				   && (info->flag_compress
@@ -7213,6 +7273,8 @@
 			goto out;
 		}
 	}
+pthread_join(*threads[0], &thread_result);
+return FALSE;
 
 	consuming_pfn = start_pfn;
 	index = -1;
@@ -7220,6 +7282,7 @@
 	gettimeofday(&last, NULL);
 
 	while (consuming_pfn < end_pfn) {
+gettimeofday(&loop1, NULL);
 		index = consuming_pfn % page_data_num;
 
 		gettimeofday(&new, NULL);
@@ -7232,17 +7295,26 @@
 		 * check pfn first without mutex locked to reduce the time
 		 * trying to lock the mutex
 		 */
-		if (page_data_buf[index].pfn != consuming_pfn)
+		if (page_data_buf[index].pfn != consuming_pfn){
+gettimeofday(&loop2, NULL);
+loop_time += (loop2.tv_sec - loop1.tv_sec) * 1000000 + (loop2.tv_usec - loop1.tv_usec);
 			continue;
+}
+gettimeofday(&find1, NULL);
+gettimeofday(&lock1, NULL);
 
 		pthread_mutex_lock(&page_data_buf[index].mutex);
 
+gettimeofday(&lock2, NULL);
+lock_time += (lock2.tv_sec - lock1.tv_sec) * 1000000 + (lock2.tv_usec - lock1.tv_usec);
+
 		/* check whether the found one is ready to be consumed */
 		if (page_data_buf[index].pfn != consuming_pfn ||
 		    page_data_buf[index].ready != 1) {
 			goto unlock;
 		}
 
+gettimeofday(&hit1, NULL);
 		if ((num_dumped % per) == 0)
 			print_progress(PROGRESS_COPY, num_dumped, info->num_dumpable);
 
@@ -7256,6 +7328,7 @@
 
 		num_dumped++;
 
+gettimeofday(&write1, NULL);
 		if (page_data_buf[index].zero == TRUE) {
 			if (!write_cache(cd_header, pd_zero, sizeof(page_desc_t)))
 				goto out;
@@ -7278,8 +7351,17 @@
 				goto out;
 
 		}
+
+gettimeofday(&write2, NULL);
+write_time += (write2.tv_sec - write1.tv_sec) * 1000000 + (write2.tv_usec - write1.tv_usec);
+
 unlock:
 		pthread_mutex_unlock(&page_data_buf[index].mutex);
+gettimeofday(&hit2, NULL);
+gettimeofday(&find2, NULL);
+hit_time += (hit2.tv_sec - hit1.tv_sec) * 1000000 + (hit2.tv_usec - hit1.tv_usec);
+find_time += (find2.tv_sec - find1.tv_sec) * 1000000 + (find2.tv_usec - find1.tv_usec);
+
 	}
 
 	ret = TRUE;
@@ -7438,8 +7520,8 @@
 		size_out = len_buf_out;
 		if ((info->flag_compress & DUMP_DH_COMPRESSED_ZLIB)
 		    && ((size_out = len_buf_out),
-			compress2(buf_out, &size_out, buf, info->page_size,
-				  Z_BEST_SPEED) == Z_OK)
+			compress2015(buf_out, &size_out, buf, info->page_size,
+				  Z_BEST_SPEED, 0) == Z_OK)
 		    && (size_out < info->page_size)) {
 			pd.flags = DUMP_DH_COMPRESSED_ZLIB;
 			pd.size  = size_out;
@@ -10314,6 +10396,11 @@
 int
 main(int argc, char *argv[])
 {
+        unsigned long total_time = 0;
+        struct timeval start_time, end_time;
+        gettimeofday(&start_time, NULL);
+
+
 	int i, opt, flag_debug = FALSE;
 
 	if ((info = calloc(1, sizeof(struct DumpInfo))) == NULL) {
@@ -10328,7 +10415,6 @@
 		goto out;
 	}
 	initialize_tables();
-
 	/*
 	 * By default, makedumpfile assumes that multi-cycle processing is
 	 * necessary to work in constant memory space.
@@ -10642,5 +10728,21 @@
 	}
 	free_elf_info();
 
+        gettimeofday(&end_time, NULL);
+        total_time = (end_time.tv_sec - start_time.tv_sec) * 1000000 + (end_time.tv_usec - start_time.tv_usec);
+        MSG("lock time: %lds%ldus\n", lock_time / 1000000, lock_time % 1000000);
+        MSG("write time: %lds%ldus\n", write_time / 1000000, write_time % 1000000);
+        MSG("hit time: %lds%ldus\n", hit_time / 1000000, hit_time % 1000000);
+        MSG("find time: %lds%ldus\n", find_time / 1000000, find_time % 1000000);
+        MSG("loop_time: %lds%ldus\n", loop_time / 1000000, loop_time % 1000000);
+        MSG("thread consume_time: %lds%ldus\n", consume_time / 1000000, consume_time % 1000000);
+for (i = 0; i < info->num_threads; i++){
+        MSG("filter_time[%d]: %lds%ldus\n", i,  filter_time[i] / 1000000, filter_time[i] % 1000000);
+        MSG("cp_time[%d]: %lds%ldus\n", i,  cp_time[i] / 1000000, cp_time[i] % 1000000);
+        MSG("compress_time[%d]: %lds%ldus\n", i,  compress_time[i] / 1000000, compress_time[i] % 1000000);
+}
+        MSG("exec time: %lds%ldus\n", total_time / 1000000, total_time % 1000000);
+
+
 	return retcd;
 }

--------------030401080106040306010902
Content-Type: application/x-troff-man; name="test2.2"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="test2.2"

--- 11	2015-07-06 12:18:08.023000000 -0400
+++ makedumpfile.c	2015-07-06 12:44:36.887000000 -0400
@@ -26,6 +26,42 @@
 #include <limits.h>
 #include <assert.h>
 
+unsigned long write_kdump_pages_parallel_cyclic_time = 0;
+struct timeval write_kdump_pages_parallel_cyclic1, write_kdump_pages_parallel_cyclic2;
+unsigned long loop_time = 0;
+unsigned long consume_time = 0;
+struct timeval loop1, loop2;
+unsigned long check_time = 0;
+struct timeval check1, check2;
+struct timeval write1, write2;
+unsigned long write_time;
+struct timeval lock1, lock2;
+unsigned long lock_time;
+struct timeval hit1, hit2;
+unsigned long hit_time;
+struct timeval find1, find2;
+unsigned long find_time;
+struct timeval timea1, timea2;
+unsigned long timea;
+struct timeval timeb1, timeb2;
+unsigned long filter_time[20];
+struct timeval filter1[20], filter2[20];
+unsigned long cp_time[20];
+struct timeval cp1[20], cp2[20];
+unsigned long compress_time[20];
+struct timeval compress_time1[20], compress_time2[20];
+unsigned long timeb;
+unsigned long count1 = 0;
+unsigned long count2 = 0;
+unsigned long count3 = 0;
+unsigned long count4 = 0;
+unsigned long count5 = 0;
+unsigned long count6 = 0;
+unsigned long count7 = 0;
+unsigned long count8 = 0;
+unsigned long count9 = 0;
+
+
 struct symbol_table	symbol_table;
 struct size_table	size_table;
 struct offset_table	offset_table;
@@ -6919,6 +6955,17 @@
 	return TRUE;
 }
 
+int compress2015(unsigned char *buf_out, unsigned long *size_out, unsigned char *buf, int page_size, int a, int thread_num)
+{
+int ret;
+gettimeofday(&compress_time1[thread_num], NULL);
+ret = compress2(buf_out, size_out, buf, info->page_size, Z_BEST_SPEED);
+gettimeofday(&compress_time2[thread_num], NULL);
+compress_time[thread_num] += (compress_time2[thread_num].tv_sec - compress_time1[thread_num].tv_sec) * 1000000 + (compress_time2[thread_num].tv_usec - compress_time1[thread_num].tv_usec);
+
+return ret;
+}
+
 void *
 kdump_thread_function_cyclic(void *arg) {
 	void *retval = PTHREAD_FAIL;
@@ -6944,6 +6991,7 @@
 	unsigned long len_buf_out_snappy =
 				snappy_max_compressed_length(info->page_size);
 #endif
+int thread_num = kdump_thread_args->thread_num;
 
 	buf = BUF_PARALLEL(kdump_thread_args->thread_num);
 	buf_out = BUF_OUT_PARALLEL(kdump_thread_args->thread_num);
@@ -6981,6 +7029,8 @@
 			 */
 			sleep(0);
 
+			index = thread_num;
+/*
 			index = pfn % page_data_num;
 
 			if (page_data_buf[index].ready != 0)
@@ -6999,12 +7049,15 @@
 			consumed_pfn = info->consumed_pfn;
 			pthread_mutex_unlock(&info->consumed_pfn_mutex);
 
+*/
 			/*
 			 * leave space for slow producer
 			 */
+/*
 			if ((long)pfn - (long)consumed_pfn > page_data_num)
 				goto unlock;
 
+*/
 			found = TRUE;
 
 			page_data_buf[index].pfn = pfn;
@@ -7030,9 +7083,13 @@
 					       mmap_cache))
 					goto fail;
 
+
+gettimeofday(&filter1[thread_num], NULL);
 			filter_data_buffer_parallel(buf, pfn_to_paddr(pfn),
 							info->page_size,
 							&info->filter_mutex);
+gettimeofday(&filter2[thread_num], NULL);
+filter_time[thread_num] += (filter2[thread_num].tv_sec - filter1[thread_num].tv_sec) * 1000000 + (filter2[thread_num].tv_usec - filter1[thread_num].tv_usec);
 
 			if ((info->dump_level & DL_EXCLUDE_ZERO)
 			    && is_zero_page(buf, info->page_size)) {
@@ -7048,14 +7105,17 @@
 			size_out = kdump_thread_args->len_buf_out;
 			if ((info->flag_compress & DUMP_DH_COMPRESSED_ZLIB)
 			    && ((size_out = kdump_thread_args->len_buf_out),
-				compress2(buf_out, &size_out, buf,
+				compress2015(buf_out, &size_out, buf,
 					  info->page_size,
-					  Z_BEST_SPEED) == Z_OK)
+					  Z_BEST_SPEED, thread_num) == Z_OK)
 			    && (size_out < info->page_size)) {
 				page_data_buf[index].flags =
 							DUMP_DH_COMPRESSED_ZLIB;
 				page_data_buf[index].size  = size_out;
+gettimeofday(&cp1[thread_num], NULL);
 				memcpy(page_data_buf[index].buf, buf_out, size_out);
+gettimeofday(&cp2[thread_num], NULL);
+cp_time[thread_num] += (cp2[thread_num].tv_sec - cp1[thread_num].tv_sec) * 1000000 + (cp2[thread_num].tv_usec - cp1[thread_num].tv_usec);
 #ifdef USELZO
 			} else if (info->flag_lzo_support
 				   && (info->flag_compress
@@ -7099,6 +7159,7 @@
 	retval = NULL;
 
 fail:
+return FALSE;
 	if (bitmap_memory_parallel.fd > 0)
 		close(bitmap_memory_parallel.fd);
 	if (bitmap_parallel.buf != NULL)
@@ -7204,6 +7265,8 @@
 		kdump_thread_args[i].page_data_buf = page_data_buf;
 		kdump_thread_args[i].cycle = cycle;
 
+kdump_thread_function_cyclic((void *)&kdump_thread_args[i]);
+return FALSE;
 		res = pthread_create(threads[i], NULL,
 				     kdump_thread_function_cyclic,
 				     (void *)&kdump_thread_args[i]);
@@ -7220,6 +7283,7 @@
 	gettimeofday(&last, NULL);
 
 	while (consuming_pfn < end_pfn) {
+gettimeofday(&loop1, NULL);
 		index = consuming_pfn % page_data_num;
 
 		gettimeofday(&new, NULL);
@@ -7232,17 +7296,26 @@
 		 * check pfn first without mutex locked to reduce the time
 		 * trying to lock the mutex
 		 */
-		if (page_data_buf[index].pfn != consuming_pfn)
+		if (page_data_buf[index].pfn != consuming_pfn){
+gettimeofday(&loop2, NULL);
+loop_time += (loop2.tv_sec - loop1.tv_sec) * 1000000 + (loop2.tv_usec - loop1.tv_usec);
 			continue;
+}
+gettimeofday(&find1, NULL);
+gettimeofday(&lock1, NULL);
 
 		pthread_mutex_lock(&page_data_buf[index].mutex);
 
+gettimeofday(&lock2, NULL);
+lock_time += (lock2.tv_sec - lock1.tv_sec) * 1000000 + (lock2.tv_usec - lock1.tv_usec);
+
 		/* check whether the found one is ready to be consumed */
 		if (page_data_buf[index].pfn != consuming_pfn ||
 		    page_data_buf[index].ready != 1) {
 			goto unlock;
 		}
 
+gettimeofday(&hit1, NULL);
 		if ((num_dumped % per) == 0)
 			print_progress(PROGRESS_COPY, num_dumped, info->num_dumpable);
 
@@ -7256,6 +7329,7 @@
 
 		num_dumped++;
 
+gettimeofday(&write1, NULL);
 		if (page_data_buf[index].zero == TRUE) {
 			if (!write_cache(cd_header, pd_zero, sizeof(page_desc_t)))
 				goto out;
@@ -7278,8 +7352,17 @@
 				goto out;
 
 		}
+
+gettimeofday(&write2, NULL);
+write_time += (write2.tv_sec - write1.tv_sec) * 1000000 + (write2.tv_usec - write1.tv_usec);
+
 unlock:
 		pthread_mutex_unlock(&page_data_buf[index].mutex);
+gettimeofday(&hit2, NULL);
+gettimeofday(&find2, NULL);
+hit_time += (hit2.tv_sec - hit1.tv_sec) * 1000000 + (hit2.tv_usec - hit1.tv_usec);
+find_time += (find2.tv_sec - find1.tv_sec) * 1000000 + (find2.tv_usec - find1.tv_usec);
+
 	}
 
 	ret = TRUE;
@@ -7438,8 +7521,8 @@
 		size_out = len_buf_out;
 		if ((info->flag_compress & DUMP_DH_COMPRESSED_ZLIB)
 		    && ((size_out = len_buf_out),
-			compress2(buf_out, &size_out, buf, info->page_size,
-				  Z_BEST_SPEED) == Z_OK)
+			compress2015(buf_out, &size_out, buf, info->page_size,
+				  Z_BEST_SPEED, 0) == Z_OK)
 		    && (size_out < info->page_size)) {
 			pd.flags = DUMP_DH_COMPRESSED_ZLIB;
 			pd.size  = size_out;
@@ -10314,6 +10397,11 @@
 int
 main(int argc, char *argv[])
 {
+        unsigned long total_time = 0;
+        struct timeval start_time, end_time;
+        gettimeofday(&start_time, NULL);
+
+
 	int i, opt, flag_debug = FALSE;
 
 	if ((info = calloc(1, sizeof(struct DumpInfo))) == NULL) {
@@ -10328,7 +10416,6 @@
 		goto out;
 	}
 	initialize_tables();
-
 	/*
 	 * By default, makedumpfile assumes that multi-cycle processing is
 	 * necessary to work in constant memory space.
@@ -10642,5 +10729,21 @@
 	}
 	free_elf_info();
 
+        gettimeofday(&end_time, NULL);
+        total_time = (end_time.tv_sec - start_time.tv_sec) * 1000000 + (end_time.tv_usec - start_time.tv_usec);
+        MSG("lock time: %lds%ldus\n", lock_time / 1000000, lock_time % 1000000);
+        MSG("write time: %lds%ldus\n", write_time / 1000000, write_time % 1000000);
+        MSG("hit time: %lds%ldus\n", hit_time / 1000000, hit_time % 1000000);
+        MSG("find time: %lds%ldus\n", find_time / 1000000, find_time % 1000000);
+        MSG("loop_time: %lds%ldus\n", loop_time / 1000000, loop_time % 1000000);
+        MSG("thread consume_time: %lds%ldus\n", consume_time / 1000000, consume_time % 1000000);
+for (i = 0; i < info->num_threads; i++){
+        MSG("filter_time[%d]: %lds%ldus\n", i,  filter_time[i] / 1000000, filter_time[i] % 1000000);
+        MSG("cp_time[%d]: %lds%ldus\n", i,  cp_time[i] / 1000000, cp_time[i] % 1000000);
+        MSG("compress_time[%d]: %lds%ldus\n", i,  compress_time[i] / 1000000, compress_time[i] % 1000000);
+}
+        MSG("exec time: %lds%ldus\n", total_time / 1000000, total_time % 1000000);
+
+
 	return retcd;
 }

--------------030401080106040306010902
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--------------030401080106040306010902--

