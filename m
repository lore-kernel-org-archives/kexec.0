Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bljbS-0008Js-Cd
 for kexec@lists.infradead.org; Sun, 18 Sep 2016 21:26:23 +0000
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8ILMeWK112667
 for <kexec@lists.infradead.org>; Sun, 18 Sep 2016 17:26:00 -0400
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25gxqhhjqk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Sun, 18 Sep 2016 17:25:59 -0400
Received: from localhost
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.vnet.ibm.com>;
 Sun, 18 Sep 2016 18:25:57 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.18.232.225])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id C7E3A1DC006D
 for <kexec@lists.infradead.org>; Sun, 18 Sep 2016 17:25:53 -0400 (EDT)
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8ILPr1i39780512
 for <kexec@lists.infradead.org>; Sun, 18 Sep 2016 18:25:53 -0300
Received: from d24av04.br.ibm.com (localhost [127.0.0.1])
 by d24av04.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8ILPrhZ010108
 for <kexec@lists.infradead.org>; Sun, 18 Sep 2016 18:25:53 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: Re: [PATHC v2 0/9] ima: carry the measurement list across kexec
Date: Sun, 18 Sep 2016 18:25:51 -0300
In-Reply-To: <87d1k3p0jy.fsf@x220.int.ebiederm.org>
References: <1472596811-9596-1-git-send-email-zohar@linux.vnet.ibm.com>
 <2097581.F8Sg9EkmE6@hactar> <87d1k3p0jy.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Message-Id: <15061913.JRHEL97DN3@hactar>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Mimi Zohar <zohar@linux.vnet.ibm.com>, kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-security-module <linux-security-module@vger.kernel.org>, linux-ima-devel@lists.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>

Am Samstag, 17 September 2016, 00:17:37 schrieb Eric W. Biederman:
> Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:
> > Hello Eric,
> > 
> > Am Freitag, 16 September 2016, 14:47:13 schrieb Eric W. Biederman:
> >> I can see tracking to see if the list has changed at some
> >> point and causing a reboot(LINUX_REBOOT_CMD_KEXEC) to fail.
> > 
> > Yes, that is an interesting feature that I can add using the checksum-
> > verifying part of my code. I can submit a patch for that if there's
> > interest, adding a reboot notifier that verifies the checksum and causes
> > a regular reboot instead of a kexec reboot if the checksum fails.
> 
> I was thinking an early failure instead of getting all of the way down
> into a kernel an discovering the tpm/ima subsystem would not
> initialized.  But where that falls in the reboot pathway I don't expect
> there is much value in it.

I'm not sure I understand. What I described doesn't involve the tpm or ima. 
I'm suggesting that if I take the parts of patch 4/5 in the kexec hand-over 
buffer series that verify the image checksum, I can submit a separate patch 
that checks the integrity of the kexec image early in kernel_kexec() and 
reverts to a regular reboot if the check fails. This would be orthogonal to 
ima carrying its measurement list across kexec.

I think there is value in that, because if the kexec image is corrupted the 
machine will just get stuck in the purgatory and (unless it's a platform 
where the purgatory can print to the console) without even an error message 
explaining what is going on. Whereas if we notice the corruption before 
jumping into the purgatory we can switch to a regular reboot and the machine 
will boot successfully.

To have an early failure, when would the checksum verification be done?
What I can think of is to have kexec_file_load accept a new flag 
KEXEC_FILE_VERIFY_IMAGE, which userspace could use to request an integrity 
check when it's about to start the reboot procedure. Then it can decide to 
either reload the kernel or use a regular reboot if the image is corrupted.

Is this what you had in mind?

> >> At least the common bootloader cases that I know of using kexec are
> >> very
> >> minimal distributions that live in a ramdisk and as such it should be
> >> very straight forward to measure what is needed at or before
> >> sys_kexec_load.  But that was completely dismissed as unrealistic so I
> >> don't have a clue what actual problem you are trying to solve.
> > 
> > We are interested in solving the problem in a general way because it
> > will be useful to us in the future for the case of an arbitrary number
> > of kexecs (and thus not only a bootloader but also multiple full-blown
> > distros may be involved in the chain).
> > 
> > But you are right that for the use case for which we currently need this
> > feature it's feasible to measure everything upfront. We can cross the
> > other bridge when we get there.
> 
> Then let's start there.  Passing the measurment list is something that
> should not be controversial.

Great!

> >> If there is anyway we can start small and not with this big scary
> >> infrastructure change I would very much prefer it.
> > 
> > Sounds good. If we pre-measure everything then the following patches
> > from my buffer hand-over series are enough:
> > 
> > [PATCH v5 2/5] kexec_file: Add buffer hand-over support for the next
> > kernel [PATCH v5 3/5] powerpc: kexec_file: Add buffer hand-over support
> > for the next kernel
> > 
> > Would you consider including those two?
> > 
> > And like I mentioned in the cover letter, patch 1/5 is an interesting
> > improvement that is worth considering.
> 
> So from 10,000 feet I think that is correct.
> 
> I am not quite certain why a new mechanism is being invented.  We have
> other information that is already passed (much of it architecture
> specific) like the flattened device tree.  If you remove the need to
> update the information can you just append this information to the
> flattened device tree without a new special mechanism to pass the data?
> 
> I am just reluctant to invent a new mechanism when there is an existing
> mechanism that looks like it should work without problems.

Michael Ellerman suggested putting the buffer contents inside the device 
tree itself, but the s390 people are also planning to implement this 
feature. That architecture doesn't use device trees, so a solution that 
depends on DTs won't help them.

With this mechanism each architecture will still need its own way of 
communicating to the next kernel where the buffer is, but I think it's 
easier to pass a base address and length than to pass a whole buffer.

I suppose we could piggyback the ima measurements buffer at the end of one 
of the other segments such as the kernel or, in the case of powerpc, the dtb 
but it looks hackish to me. I think it's cleaner to put it in its own 
segment.

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
