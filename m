Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1RNfAW-0003sz-23
 for kexec@lists.infradead.org; Tue, 08 Nov 2011 06:28:25 +0000
Message-ID: <4EB8CC84.6090001@redhat.com>
Date: Tue, 08 Nov 2011 14:30:28 +0800
From: Dave Young <dyoung@redhat.com>
MIME-Version: 1.0
Subject: Re: ppc64 kexec -p failed
References: <4EB38EB1.5070904@redhat.com> <4EB8C329.1010509@linux.vnet.ibm.com>
In-Reply-To: <4EB8C329.1010509@linux.vnet.ibm.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: kexec@lists.infradead.org

On 11/08/2011 01:50 PM, Mahesh Jagannath Salgaonkar wrote:

> On 11/04/2011 12:35 PM, Dave Young wrote:
>> Hi,


Thanks for your reply.

>>
>> When use crashkernel=128M@256M at a ppc64 machine, kexec -p vmlinuz
>> failed with:
>> Could not find a free area of memory of faa448 bytes...
>> Could not find a free area of memory of 142721d bytes...
>>
>> Is this a know issue or Is there limitation of the crashkernel base addr?
> 
> On Power, crashkernel base addr must fall inside RMO region. The is
> because ppc64 kernel needs some of its memory in the RMO region. The
> memory ranges below shows that the system has RMO region of size 128M,
> Hence crashkernel base addr @64M should work just fine.


Then what about let kernel reservation just fail with such case? And
better at the same time give out a warning about base addr from cmdline
is out of RMO

Or at least we should add this info into kernel doc.

> 
>>
>> Detail info as below (define DEBUG when building):
>>
> ...
> ...
>> 0000000000000000-0000000008000000 : 0
> ...
> ...
> 
> Thanks,
> -Mahesh.
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec



-- 
Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
