Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bl0WE-0006kO-61
 for kexec@lists.infradead.org; Fri, 16 Sep 2016 21:17:59 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1472596811-9596-1-git-send-email-zohar@linux.vnet.ibm.com>
 <20160831135047.4b05a7f912f158ed5f888241@linux-foundation.org>
 <1472683086.2607.17.camel@linux.vnet.ibm.com>
 <1473954263.2526.88.camel@linux.vnet.ibm.com>
 <87lgyrsk3i.fsf@x220.int.ebiederm.org>
Date: Fri, 16 Sep 2016 16:03:47 -0500
In-Reply-To: <87lgyrsk3i.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
 message of "Fri, 16 Sep 2016 14:47:13 -0500")
Message-ID: <871t0jr1zg.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATHC v2 0/9] ima: carry the measurement list across kexec
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ima-devel@lists.sourceforge.net, linux-security-module <linux-security-module@vger.kernel.org>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>

ebiederm@xmission.com (Eric W. Biederman) writes:

> Mimi Zohar <zohar@linux.vnet.ibm.com> writes:
>
>> Hi Andrew,
>>
>> On Wed, 2016-08-31 at 18:38 -0400, Mimi Zohar wrote:
>>> On Wed, 2016-08-31 at 13:50 -0700, Andrew Morton wrote:
>>> > On Tue, 30 Aug 2016 18:40:02 -0400 Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
>>> > 
>>> > > The TPM PCRs are only reset on a hard reboot.  In order to validate a
>>> > > TPM's quote after a soft reboot (eg. kexec -e), the IMA measurement list
>>> > > of the running kernel must be saved and then restored on the subsequent
>>> > > boot, possibly of a different architecture.
>>> > > 
>>> > > The existing securityfs binary_runtime_measurements file conveniently
>>> > > provides a serialized format of the IMA measurement list. This patch
>>> > > set serializes the measurement list in this format and restores it.
>>> > > 
>>> > > Up to now, the binary_runtime_measurements was defined as architecture
>>> > > native format.  The assumption being that userspace could and would
>>> > > handle any architecture conversions.  With the ability of carrying the
>>> > > measurement list across kexec, possibly from one architecture to a
>>> > > different one, the per boot architecture information is lost and with it
>>> > > the ability of recalculating the template digest hash.  To resolve this
>>> > > problem, without breaking the existing ABI, this patch set introduces
>>> > > the boot command line option "ima_canonical_fmt", which is arbitrarily
>>> > > defined as little endian.
>>> > > 
>>> > > The need for this boot command line option will be limited to the
>>> > > existing version 1 format of the binary_runtime_measurements.
>>> > > Subsequent formats will be defined as canonical format (eg. TPM 2.0
>>> > > support for larger digests).
>>> > > 
>>> > > This patch set pre-req's Thiago Bauermann's "kexec_file: Add buffer
>>> > > hand-over for the next kernel" patch set. 
>>> > > 
>>> > > These patches can also be found in the next-kexec-restore branch of:
>>> > > git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
>>> > 
>>> > I'll merge these into -mm to get some linux-next exposure.  I don't
>>> > know what your upstream merge plans will be?
>>> 
>>> Sounds good.  I'm hoping to get some review/comments on this patch set
>>> as well.  At the moment, I'm chasing down a kernel test robot report
>>> from this afternoon.
>>
>> My concern about changing the canonical format as originally defined in
>> patch 9/9 from big endian to little endian never materialized.  Andreas
>> Steffan, the patch author, is happy either way.
>>
>> We proposed two methods of addressing Eric Biederman's concerns of not
>> including the IMA measurement list segment in the kexec hash as
>> described in  https://lkml.org/lkml/2016/9/9/355.
>>
>> - defer calculating and verifying the serialized IMA measurement list
>> buffer hash to IMA
>> - calculate the kexec hash on load, verify it on the kexec execute,
>> before re-calculating and updating it.
>
> I need to ask: How this is anticipated to interact with kexec on panic?
> Because honestly I can't see this ever working in that case.  The
> assumption is that the original kernel has gone crazy.  So from a
> practical standpoint any trusted path should have been invalided.
>
> This entire idea of updating the kexec image makes me extremely
> extremely nervious.  It feels like sticking a screw driver through the
> spokes of your bicicle tires while ridding down the road.
>
> I can see tracking to see if the list has changed at some
> point and causing a reboot(LINUX_REBOOT_CMD_KEXEC) to fail.
>
> At least the common bootloader cases that I know of using kexec are very
> minimal distributions that live in a ramdisk and as such it should be
> very straight forward to measure what is needed at or before
> sys_kexec_load.  But that was completely dismissed as unrealistic so I
> don't have a clue what actual problem you are trying to solve.
>
> If there is anyway we can start small and not with this big scary
> infrastructure change I would very much prefer it.

I have thought about this a little more and the entire reason for
updating things on the fly really really disturbs me.  To prove you are
trusted the new kernel is going to have to present that whole trusted
list of files to someone.  Which means in my naive understanding of the
situation that any change in that list of files is going to have to be
tracked and audited.

So the idea that we have to be super flexible in the kernel (when we are
inflexible in userspace) does not make a bit of sense to me.

So no.  I am not in favor of adding a mechanism to kexec that gives me
the screaming heebie jeebies and that appears to be complete at odds
with what that mechanism is trying to do.

AKA if you are going to trust any old thing, or any old change on the
reboot path than it doesn't make sense to track them.  If you are
tracking them it doesn't make sense to have a mechanism where anything
goes.

Eric


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
