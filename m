Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1J1oVB-0005L2-LW
	for kexec@lists.infradead.org; Mon, 10 Dec 2007 19:41:23 +0000
Message-ID: <475D95EB.4000006@redhat.com>
Date: Mon, 10 Dec 2007 11:39:23 -0800
From: Ben Woodard <woodard@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH] kexec: force x86_64 arches to boot kdump kernels on	boot
	cpu
References: <474F7177.7050306@redhat.com> <20071130144250.GC23810@redhat.com>
	<20071130145131.GB5822@hmsendeavour.rdu.redhat.com>
	<20071206213951.GB28898@hmsreliant.think-freely.org>
	<20071206221143.GC2863@redhat.com>
	<m1bq93s5r8.fsf@ebiederm.dsl.xmission.com>
	<86802c440712070050s3c5017a4w8e747a7035d10d3a@mail.gmail.com>
	<86802c440712070122q6e5824bcp12e1c3f560e2ab53@mail.gmail.com>
	<20071207142144.GA10389@hmsendeavour.rdu.redhat.com>
	<m1y7c6qrlh.fsf@ebiederm.dsl.xmission.com>
	<20071207184810.GB18485@hmsreliant.think-freely.org>
In-Reply-To: <20071207184810.GB18485@hmsreliant.think-freely.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Neil Horman <nhorman@tuxdriver.com>, kexec@lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Neil Horman wrote:
> On Fri, Dec 07, 2007 at 11:36:58AM -0700, Eric W. Biederman wrote:
>> Neil Horman <nhorman@redhat.com> writes:
>>
>>> this seems reasonable, I can reroll the patch for this.  As I think about it I'm
>>> also going to update the patch to make this check occur for any pci class 0600
>>> device from vendor AMD, since its possible that more than just nvidia chipsets
>>> can be affected.
>>>
>>> I'll repost as soon as I've tested, thanks!
>> Thanks.
>>
>> Neil in your testing please confirm the preconditions for setting 
>> the Apic Extended Broadcast flag (bit 17) are present.
>>
> The systems that I have here do _not_ in fact have that precondition, but the
> systems from Ben, who originoally reported the problem do have that
> precondition, and he has reported that this fixes the hang in the kdump boot.
> 
>> If that is the case it makes sense to always set that bit on conforming
>> systems but we will also want to print a message noting that the
>> BIOS has a bug, and we are working around it.
>>
> I've got two printk's in this patch, one that indicates that Extended APIC ID's
> are in use, and a second that indicates that there is a mismatch between the use
> of extended APIC ids (bit 18) and the lack of an extended APIC id dest mask for
> interrupt packets (bit 17).  Not sure if that meets you're requirements, but I
> think its sufficient.  If you disagree, let me know and we can enhance them.
> 
> Thanks
> Neil
> 
Is enough to say if the machine has 8 cpus and it is using a broadcast
of 0x0f then there is a BIOS bug?

- -ben

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFHXZXrugekqaRDL9cRAvkUAKCBLq+vXPqjOgDxD+tsYRU8W2rDwgCfR8S/
K9B5vS1dwGZxeMeMceSxpdE=
=9oKY
-----END PGP SIGNATURE-----

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
