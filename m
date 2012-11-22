Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e2.ny.us.ibm.com ([32.97.182.142])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TbaMi-0007jx-W8
 for kexec@lists.infradead.org; Thu, 22 Nov 2012 17:15:05 +0000
Received: from /spool/local
 by e2.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <aravinda@linux.vnet.ibm.com>;
 Thu, 22 Nov 2012 12:14:59 -0500
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 4440EC90041
 for <kexec@lists.infradead.org>; Thu, 22 Nov 2012 12:14:56 -0500 (EST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 qAMHEtlk341382
 for <kexec@lists.infradead.org>; Thu, 22 Nov 2012 12:14:55 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qAMHEsIX004459
 for <kexec@lists.infradead.org>; Thu, 22 Nov 2012 15:14:55 -0200
Message-ID: <50AE5D89.2090101@linux.vnet.ibm.com>
Date: Thu, 22 Nov 2012 22:44:49 +0530
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/7] makedumpfile security key filtering with eppic
References: <50A4E524.8020702@linux.vnet.ibm.com>
 <348117236.32179739.1352989665917.JavaMail.root@redhat.com>
 <20121115155557.GF2529@redhat.com> <50A60CF2.6010309@linux.vnet.ibm.com>
 <20121116143649.GA4515@redhat.com>
 <20121120184755.01bc3c780dc226fe32f06e66@mxc.nes.nec.co.jp>
 <50AC809E.9060907@linux.vnet.ibm.com> <20121121135721.GB13114@redhat.com>
In-Reply-To: <20121121135721.GB13114@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: ananth@in.ibm.com, mahesh@linux.vnet.ibm.com, kexec@lists.infradead.org, LChouinard@s2sys.com, tachibana@mxm.nes.nec.co.jp, Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, anderson@redhat.com, buendgen@de.ibm.com



On 2012-11-21 19:27, Vivek Goyal wrote:

> On Wed, Nov 21, 2012 at 12:49:58PM +0530, Aravinda Prasad wrote:
>>
>>
>> On 2012-11-20 15:17, Atsushi Kumagai wrote:
>>
>> ...
>>
>>
>>>>>
>>>>>
>>>>> As I mentioned, we don't need vmlinux in initramfs as filtering is done
>>>>> during post processing only.
>>>>
>>>> You are missing the point. The point is that despite the fact that
>>>> scrubbing will never be done from initramfs, all the users will pay
>>>> penalty for increased makedumpfile size.
>>>>
>>>> So why not write a separate tool (scrub-vmcore) so that makedumpfile
>>>> users don't pay the bloated size penatly.
>>>
>>> As Vivek said, I think it's difficult to persuade almost all distributor
>>> to specify EPPIC=on.
>>>
>>> So, it seems that separate tool is better way for both user and distributor.
>>> If you will make it, I will drop eppic support from v1.5.1 and export core
>>> functions from makedumpfile as library for such tools in the future.
>>>
>>> Does this meet your purpose, Aravinda ?
>>
>>
>> Vivek, Atsushi,
>>
>> How about distributions building two targets one with default
>> makedumpfile and other with EPPIC=on, which can be done by a simple
>> modification to Makefile.
> 
> That's not a good idea. Generally distributions don't ship multiple
> binaries with minor differences like that. I think going with a
> separate tool for doing this kind of filtering is better.


Customers who want to filter their dump would certainly prefer a single
tool and a single shot to throw away pages, scrub data and then
compress, split or send the resulting dump to some target using ssh.
This important functionality is lost if scrubbing is not part of
makedumpfile and a separate tool is developed which just does scrubbing.

> 
> Thanks
> Vivek
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 


-- 
Regards,
Aravinda


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
