Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by casper.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RXUd4-0006uH-1I
 for kexec@lists.infradead.org; Mon, 05 Dec 2011 09:14:33 +0000
Date: Mon, 5 Dec 2011 17:50:55 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [RFC] makedumpfile, crash: LZO compression support
Message-Id: <20111205175055.fd3ddb2f.kumagai-atsushi@mxc.nes.nec.co.jp>
In-Reply-To: <20111118.154853.246506690.d.hatayama@jp.fujitsu.com>
References: <20111117211946.3e27b840.d.hatayama@jp.fujitsu.com>
 <20111118121458.5c007bda.kumagai-atsushi@mxc.nes.nec.co.jp>
 <20111118.154853.246506690.d.hatayama@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Mon__5_Dec_2011_17_50_55_+0900_PMXZzefjDNxqJ8zq"
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
To: crash-utility@redhat.com, kexec@lists.infradead.org

This is a multi-part message in MIME format.

--Multipart=_Mon__5_Dec_2011_17_50_55_+0900_PMXZzefjDNxqJ8zq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

> > Hello Hatayama-san,
> > 
> > Thank you for your work.
> > 
> >> Performance Comparison:
> >> 
> >>   Sample Data
> >> 
> >>     Ideally, I must have measured the performance for many enough
> >>     vmcores generated from machines that was actually running, but now
> >>     I don't have enough sample vmcores, I couldn't do so. So this
> >>     comparison doesn't answer question on I/O time improvement. This
> >>     is TODO for now.
> > 
> > I'll measure the performance for actual vmcores by makedumpfile.
> > Please wait for a while.

I measured the performance of makedumpfile for some vmcores.
Please see below.


Sample Data
  
  To simulate a working server, I captured VMCOREs while almost all pages 
  were alloceted and filled with random data. (See attached file "fill_random.c")

  I captured the VMCOREs of 5GB, 7.5GB and 10GB in the same condition.

How to measure

  I measured the total execution time and the size of output file.

  $ time makedumpfile --message-level 16 [-c|-l| ] vmcore dumpfile

Result

    See attached file "result.txt".


This time, lzo's compression was the quickest, and lzo's compression ratio is
almost the same(only a bit worse) as zlib's.
It seems good, and I will merge the patch set into the makedumpfile.

What is your opinion, Dave?


Thanks.
KUMAGAI, Atsushi

> 
> That's very helpful. Thanks in advance.
> 
> But of course I'm also still looking for alternative way.
> 
> Thanks.
> HATAYAMA, Daisuke
> 

--Multipart=_Mon__5_Dec_2011_17_50_55_+0900_PMXZzefjDNxqJ8zq
Content-Type: text/plain;
 name="result.txt"
Content-Disposition: attachment;
 filename="result.txt"
Content-Transfer-Encoding: 7bit

				lzo		zlib		non-compress
     5GBytes
total time(sec)			238		464		252
total time ratio(%)		94.4		184.1		100
output size(KBytes)		4812695		4771490		5156005
compression size ratio(%)	93.2		92.4		100


     7.5GBytes
total time(sec)			358		685		376
total time ratio(%)		95.2		182.1		100
output size(KBytes)		7193681		7130501		7782665
compression size ratio(%)	92.4		91.6		100


     10GBytes
total time(sec)			493		929		527
total time ratio(%)		93.5		176.3		100
output size(KBytes)		9980424		9932498		10460825
compression size ratio(%)	95.4		94.9		100



[about sample data]

Sample data is random, and it has deviation in compression ratio.
I show the number of pages below which were compressed.
(See attached patch "compressed_page_report.patch")

					lzo			zlib
	5GByte
compressed page				120052			122238
non-compressed page			1505548			1503362
compression page ratio(%)   		7.39			7.52


	7.5GByte
compressed page				206481			209758
non-compressed page			2071919			2068642
compression page ratio(%)   		9.06			9.21


	10GByte	
compressed page				160327			161229
non-compressed page			2783673			2782771
compression page ratio(%)		5.45			5.48

--Multipart=_Mon__5_Dec_2011_17_50_55_+0900_PMXZzefjDNxqJ8zq
Content-Type: application/octet-stream;
 name="compressed_page_report.patch"
Content-Disposition: attachment;
 filename="compressed_page_report.patch"
Content-Transfer-Encoding: base64

Y29tbWl0IGZmMmU0ZWQzZTQwZmE3Mjc5ODA5MTUxMzdiZTQ2NWQ1ZGE5MTljMmENCkF1dGhvcjog
QXRzdXNoaSBLdW1hZ2FpIDxrdW1hZ2FpLWF0c3VzaGlAbXhjLm5lcy5uZWMuY28uanA+DQpEYXRl
OiAgIE1vbiBEZWMgNSAxNDowOTo1OSAyMDExICswOTAwDQoNCiAgICBtYWtlZHVtcGZpbGU6IEFk
ZCBDb21wcmVzc2VkIHBhZ2UgcmVwb3J0DQoKZGlmZiAtLWdpdCBhL21ha2VkdW1wZmlsZS5jIGIv
bWFrZWR1bXBmaWxlLmMNCmluZGV4IDMzNmE4ZmMuLjk3NTI5ZjQgMTAwNjQ0DQotLS0gYS9tYWtl
ZHVtcGZpbGUuYw0KKysrIGIvbWFrZWR1bXBmaWxlLmMNCkBAIC00Miw2ICs0MiwxMSBAQCB1bnNp
Z25lZCBsb25nIGxvbmcgcGZuX2NhY2hlX3ByaXZhdGU7DQogdW5zaWduZWQgbG9uZyBsb25nIHBm
bl91c2VyOw0KIHVuc2lnbmVkIGxvbmcgbG9uZyBwZm5fZnJlZTsNCg0KKy8qDQorICogVGhlIG51
bWJlcnMgb2YgdGhlIGNvbXByZXNzZWQgcGFnZXMNCisgKi8NCit1bnNpZ25lZCBsb25nIGxvbmcg
cGZuX2NvbXByZXNzZWQ7DQorDQogaW50IHJldGNkID0gRkFJTEVEOyAgICAvKiByZXR1cm4gY29k
ZSAqLw0KDQogI2RlZmluZSBJTklUSUFMSVpFX0xPTkdfVEFCTEUodGFibGUsIHZhbHVlKSBcDQpA
QCAtNDQzMCw2ICs0NDM1LDggQEAgd3JpdGVfa2R1bXBfcGFnZXMoc3RydWN0IGNhY2hlX2RhdGEg
KmNkX2hlYWRlciwgc3RydWN0IGNhY2hlX2RhdGEgKmNkX3BhZ2UpDQogICAgICAgIGNvbnN0IG9m
Zl90IGZhaWxlZCA9IChvZmZfdCktMTsNCiAgICAgICAgbHpvX2J5dGVwIHdya21lbSA9IE5VTEw7
DQoNCisgICAgICAgcGZuX2NvbXByZXNzZWQgPSAwOw0KKw0KICAgICAgICBpbnQgcmV0ID0gRkFM
U0U7DQoNCiAgICAgICAgaWYgKGluZm8tPmZsYWdfZWxmX2R1bXBmaWxlKQ0KQEAgLTQ1MzYsNyAr
NDU0Myw5IEBAIHdyaXRlX2tkdW1wX3BhZ2VzKHN0cnVjdCBjYWNoZV9kYXRhICpjZF9oZWFkZXIs
IHN0cnVjdCBjYWNoZV9kYXRhICpjZF9wYWdlKQ0KICAgICAgICAgICAgICAgICAgICAmJiAoKGRf
ZW5kID0gZ2V0ZHRpbWUoKSksIFRSVUUpDQogICAgICAgICAgICAgICAgICAgICYmIChzaXplX291
dCA8IGluZm8tPnBhZ2Vfc2l6ZSkpIHsNCg0KLSAgICAgICAgICAgICAgICAgICAgICAgZF9jb21w
cmVzcyArPSBkX2VuZCAtIGRfc3RhcnQ7DQorICAgICAgICAgICAgICAgICAgICAgICBkX2NvbXBy
ZXNzICs9IGRfZW5kIC0gZF9zdGFydDsNCisNCisgICAgICAgICAgICAgICAgICAgICAgIHBmbl9j
b21wcmVzc2VkKys7DQoNCiAgICAgICAgICAgICAgICAgICAgICAgIHBkLmZsYWdzID0gRFVNUF9E
SF9DT01QUkVTU0VEX1pMSUI7DQogICAgICAgICAgICAgICAgICAgICAgICBwZC5zaXplID0gc2l6
ZV9vdXQ7DQpAQCAtNDU1MCw4ICs0NTU5LDEwIEBAIHdyaXRlX2tkdW1wX3BhZ2VzKHN0cnVjdCBj
YWNoZV9kYXRhICpjZF9oZWFkZXIsIHN0cnVjdCBjYWNoZV9kYXRhICpjZF9wYWdlKQ0KICAgICAg
ICAgICAgICAgICAgICAgICAgICAgJiYgKChkX2VuZCA9IGdldGR0aW1lKCkpLCBUUlVFKQ0KICAg
ICAgICAgICAgICAgICAgICAgICAgICAgJiYgKHNpemVfb3V0IDwgaW5mby0+cGFnZV9zaXplKSkg
ew0KDQotICAgICAgICAgICAgICAgICAgICAgICBkX2NvbXByZXNzICs9IGRfZW5kIC0gZF9zdGFy
dDsNCisgICAgICAgICAgICAgICAgICAgICAgIGRfY29tcHJlc3MgKz0gZF9lbmQgLSBkX3N0YXJ0
Ow0KDQorICAgICAgICAgICAgICAgICAgICAgICBwZm5fY29tcHJlc3NlZCsrOw0KKw0KICAgICAg
ICAgICAgICAgICAgICAgICAgcGQuZmxhZ3MgPSBEVU1QX0RIX0NPTVBSRVNTRURfTFpPOw0KICAg
ICAgICAgICAgICAgICAgICAgICAgcGQuc2l6ZSA9IHNpemVfb3V0Ow0KICAgICAgICAgICAgICAg
ICAgICAgICAgbWVtY3B5KGJ1ZiwgYnVmX291dCwgcGQuc2l6ZSk7DQpAQCAtNTYzMSw2ICs1NjQy
LDggQEAgcHJpbnRfcmVwb3J0KHZvaWQpDQogICAgICAgIFJFUE9SVF9NU0coIk1lbW9yeSBIb2xl
ICAgICA6IDB4JTAxNmxseFxuIiwgcGZuX21lbWhvbGUpOw0KICAgICAgICBSRVBPUlRfTVNHKCIt
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLVxuIik7DQog
ICAgICAgIFJFUE9SVF9NU0coIlRvdGFsIHBhZ2VzICAgICA6IDB4JTAxNmxseFxuIiwgaW5mby0+
bWF4X21hcG5yKTsNCisgICAgICAgUkVQT1JUX01TRygiICAgIENvbXByZXNzZWQgcGFnZXMgICAg
ICAgIDogMHglMDE2bGx4XG4iLCBwZm5fY29tcHJlc3NlZCk7DQorICAgICAgIFJFUE9SVF9NU0co
IiAgICBOb25jb21wcmVzc2VkIHBhZ2VzICAgICA6IDB4JTAxNmxseFxuIiwgaW5mby0+bWF4X21h
cG5yIC0gcGZuX2NvbXByZXNzZWQpOw0KICAgICAgICBSRVBPUlRfTVNHKCJcbiIpOw0KIH0=

--Multipart=_Mon__5_Dec_2011_17_50_55_+0900_PMXZzefjDNxqJ8zq
Content-Type: text/x-csrc;
 name="fill_random.c"
Content-Disposition: attachment;
 filename="fill_random.c"
Content-Transfer-Encoding: 7bit

#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>
#include <stdlib.h>
#include <errno.h>
#include <string.h>
#include <sys/time.h>

#define MEGABYTES	(1024*1024)

int pagefault_megabyte(char **ptr)
{
	char *ptr_local;
	int j;

	ptr_local = *ptr;

	srand((unsigned) time(NULL));	
	for (j = 0; j < MEGABYTES; j++, ptr_local++) {
  	        memset(ptr_local, rand()%256, 1);
	}
}

main(int argc, char *argv[])
{
	int i, mem_mega_bytes;
	char *ptr[1024*1024];

	if (argc != 2) {
		printf("Invalid param\n");
		return 1;
	}
	mem_mega_bytes = atoi(argv[1]);

	for (i = 0; i < mem_mega_bytes; i++) {
		ptr[i] = malloc(MEGABYTES);
		if (ptr[i] == NULL) {
			printf("malloc error. (%s)\n", strerror(errno));
			exit(1);
		}
	}

retry:
	for (i = 0; i < mem_mega_bytes; i++) {
		pagefault_megabyte(&ptr[i]);
	}
	goto retry;
}
--Multipart=_Mon__5_Dec_2011_17_50_55_+0900_PMXZzefjDNxqJ8zq
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--Multipart=_Mon__5_Dec_2011_17_50_55_+0900_PMXZzefjDNxqJ8zq--

