Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VCnlN-0006Cz-6D
 for kexec@lists.infradead.org; Fri, 23 Aug 2013 09:34:39 +0000
Message-ID: <52172AB3.7080809@mxc.nes.nec.co.jp>
Date: Fri, 23 Aug 2013 18:26:11 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
MIME-Version: 1.0
Subject: Re: makefumpfile tool to estimate vmcore file size
References: <51E64EA6.9040209@redhat.com>
 <20130724160640.84e00a3a2e4d811fbdfaa34e@mxc.nes.nec.co.jp>
 <20130802032906.GB7653@dhcp-16-252.nay.redhat.com>
In-Reply-To: <20130802032906.GB7653@dhcp-16-252.nay.redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: bhe@redhat.com
Cc: kexec@lists.infradead.org

Hello Baoquan,

(2013/08/02 12:29), Baoquan He wrote:
> Hi Atsushi,
>
> Sorry to reply so late.
> By discussing with customer, their idea is below:
>
> *******************************
> The idea about a tool like this is that it works in the 1st kernel and
> that it will tell you how big the vmcore will be based on what filtering
> level and/or compression selected in kdump.conf. Our customer wrote a perl
> script to demonstrate this, I have attached it as attachment. This perl
> script only looks at uncompressed and dumplevel 31 - in the 1st kernel.
> Being told about the dump size when in the 2nd (kdump/kexec kernel) is
> somewhat pointless as you are not then in a position to adjust the
> destination filesystem to accommodate the vmcore size should you need to.
> This is proactively looking at what size is required for a vmcore.
>
> If the kdump.conf says "filter level 11, compress", a tool to estimate
> the vmcore size should take that into account, gauge what pages would
> be included in that, and roughly what size that would equate to
> compressed. The problem is that this is quite dynamic, so the perl
> script deliberately only looks at filter level 31 (trying to work the
> rest out was too hard for me to do).
> **********************************
>
> Per discussion with customer, I think the tool is expected to work in
> 1st kernel. With configuration file which specify the fileter level and
> compression algorithm, a rough vmcore size can be given. Since they
> maybe have thousands of servers, an estimated vmcore size can be very
> helpful to refer to.

I understand your customer's idea, I also think it's useful for
such situation.
I'm afraid that I can't take time for developing new feature now,
but I'll accept the estimation feature if anyone makes that.

IMHO, I think /proc/kcore is better interface for analyzing live
system while it's ELF format. This is because that the logic for
/proc/vmcore might can be reused with small fix.


Thanks
Atsushi Kumagai.

>
> Baoquan
> Thanks a lot
>
> On 07/24/13 at 04:06pm, Atsushi Kumagai wrote:
>> On Wed, 17 Jul 2013 15:58:30 +0800
>> Baoquan <bhe@redhat.com> wrote:
>>
>>> #makedumpfile -d31 -c/-l/-p
>>>
>>> TYPE			PAGES		INCLUDED
>>>
>>> Zero Page		x		no
>>> Cache Without Private	x           	no
>>> Cache With Private	x		no
>>> User Data		x		no
>>> Free Page		x		no
>>> Kernel Code		x		yes
>>> Kernel Data		x		yes
>>>
>>> Total Pages on system:			311000  (Just for example)
>>> Total Pages included in kdump:		160000  (Just for example)
>>> Estimated vmcore file size:		48000  (30% compression ratio)
>>> ##########################################################
>>
>> Does this image mean that you want to run makedumpfile in 1st
>> kernel without generating a actual dumpfile ?
>> Unfortunately, makedumpfile can't work in 1st kernel because it
>> only supports /proc/vmcore as input data.
>>
>> If you don't persist in doing in 1st kernel, your desire can be
>> achieved by modifying print_report() and discarding a output
>> data to /dev/null, and running makedumpfile via kdump as usual.
>>
>>> By configured dump level, total pages included in kdump can be computed.
>>> Then with option which specify a compression algorithm, an estimated
>>> vmcore file size can be given. Though the estimated value is changed
>>> dynamically with time, it does give user a valuable reference.
>>
>> Compression ratio is very dependent on the memory usage.
>> So I think it's difficult to estimate the size when any compression
>> algorithm is specified.
>>
>>
>> Thanks
>> Atsushi Kumagai
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
