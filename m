Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20190708211528.12392-1-pasha.tatashin@soleen.com>
Date: Mon, 08 Jul 2019 18:53:41 -0500
In-Reply-To: <20190708211528.12392-1-pasha.tatashin@soleen.com> (Pavel
 Tatashin's message of "Mon, 8 Jul 2019 17:15:23 -0400")
Message-ID: <87sgrgjd6i.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [v1 0/5] allow to reserve memory for normal kexec kernel
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
To: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: sashal@kernel.org, corbet@lwn.net, catalin.marinas@arm.com, linux-doc@vger.kernel.org, kexec@lists.infradead.org, jmorris@namei.org, linux-kernel@vger.kernel.org, will@kernel.org, linux-arm-kernel@lists.infradead.org

Pavel Tatashin <pasha.tatashin@soleen.com> writes:

> Currently, it is only allowed to reserve memory for crash kernel, because
> it is a requirement in order to be able to boot into crash kernel without
> touching memory of crashed kernel is to have memory reserved.
>
> The second benefit for having memory reserved for kexec kernel is
> that it does not require a relocation after segments are loaded into
> memory.
>
> If kexec functionality is used for a fast system update, with a minimal
> downtime, the relocation of kernel + initramfs might take a significant
> portion of reboot.
>
> In fact, on the machine that we are using, that has ARM64 processor
> it takes 0.35s to relocate during kexec, thus taking 52% of kernel reboot
> time:
>
> kernel shutdown	0.03s
> relocation	0.35s
> kernel startup	0.29s
>
> Image: 13M and initramfs is 24M. If initramfs increases, the relocation
> time increases proportionally.

Something is very very wrong there.

Last I measured memory bandwidth seriously I could touch a Gigabyte per
second easily, and that was nearly 20 years ago.  Did you manage to
disable caching or have some particularly slow code that does the
reolocations.

There is a serious cost to reserving memory in that it is simply not
available at other times.  For kexec on panic there is no other reliable
way to get memory that won't be DMA'd to.

We have options in this case and I would strongly encourage you to track
down why that copy in relocation is so very slow.  I suspect a 4KiB page
size is large enough that it can swamp pointer following costs.

My back of the napkin math says even 20 years ago your copying costs
should be only 0.037s.  The only machine I have ever tested on where
the copy costs were noticable was my old 386.

Maybe I am out to lunch here but a claim that your memory only runs
at 100MiB/s (the speed of my spinning rust hard drive) is rather
incredible.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
