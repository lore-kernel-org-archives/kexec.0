Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from smtp02.citrix.com ([66.165.176.63])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vemdh-0004QJ-K1
 for kexec@lists.infradead.org; Fri, 08 Nov 2013 14:02:22 +0000
Message-ID: <527CEED7.4040807@citrix.com>
Date: Fri, 8 Nov 2013 14:01:59 +0000
From: Andrew Cooper <andrew.cooper3@citrix.com>
MIME-Version: 1.0
Subject: Re: [Xen-devel] [PATCHv10 0/9] Xen: extend kexec hypercall for use
 with pv-ops kernels
References: <1383749386-11891-1-git-send-email-david.vrabel@citrix.com>
 <20131107211651.GC11159@olila.local.net-space.pl> <527CE397.10101@citrix.com>
 <20131108134829.GE11159@olila.local.net-space.pl>
In-Reply-To: <20131108134829.GE11159@olila.local.net-space.pl>
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
Cc: kexec@lists.infradead.org, Keir Fraser <keir@xen.org>, David Vrabel <david.vrabel@citrix.com>, Jan Beulich <jbeulich@suse.com>, xen-devel@lists.xen.org

On 08/11/13 13:48, Daniel Kiper wrote:
> On Fri, Nov 08, 2013 at 01:13:59PM +0000, David Vrabel wrote:
>> Keir,
>>
>> Sorry, forgot to CC you on this series.
>>
>> Can we have your opinion on whether this kexec series can be merged?
>> And if not, what further work and/or testing is required?
>>
>> On 07/11/13 21:16, Daniel Kiper wrote:
>>> On Wed, Nov 06, 2013 at 02:49:37PM +0000, David Vrabel wrote:
>>>> The series (for Xen 4.4) improves the kexec hypercall by making Xen
>>>> responsible for loading and relocating the image.  This allows kexec
>>>> to be usable by pv-ops kernels and should allow kexec to be usable
>>>> from a HVM or PVH privileged domain.
>>>>
>>>> I have now tested this with a Linux kernel image using the VGA console
>>>> which was what was causing problems in v9 (this turned out to be a
>>>> kexec-tools bug).
>>>>
>>>> The required patch series for kexec-tools will be posted shortly and
>>>> are available from the xen-v7 branch of:
>>> In general it works. However, quite often I am not able to execute panic
>>> kernel. Machine hangs with following message:
>> I cannot reproduce any failures, neither on my dev box nor on any of the
>> automated XenServer tests that run on a range of different hardware
>> platforms.  I find kexec to be very reliable and an earlier version of
>> this series has been in production within XenServer for a while now and
>> has seen real use in the field.
>>
>> None of the issues reported so far have been regressions but failures in
>> specific uses of the new support for pv-ops kernels.
>>
>> I really can't see how I can do anything else to make this series
>> acceptable for merging.
> I think that in general it is OK. However, we must solve discovered
> issues or confirm that it is not a problem of current implementation.
> That is all. I hope that we finally do that next week (FYI, Monday
> is public holiday in Poland).

What outstanding issues do you think are present then?

~Andrew

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
