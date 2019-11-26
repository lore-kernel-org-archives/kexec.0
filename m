Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]
 helo=us-smtp-delivery-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iZi7y-00076v-Qr
 for kexec@lists.infradead.org; Tue, 26 Nov 2019 21:12:09 +0000
Received: by mail-lj1-f197.google.com with SMTP id y17so3920224ljm.16
 for <kexec@lists.infradead.org>; Tue, 26 Nov 2019 13:11:59 -0800 (PST)
MIME-Version: 1.0
References: <CAJ2QiJLBcmdVrmJmfKehadUzzUkmMsn8b2BxmGh7LHXzo7PtJw@mail.gmail.com>
In-Reply-To: <CAJ2QiJLBcmdVrmJmfKehadUzzUkmMsn8b2BxmGh7LHXzo7PtJw@mail.gmail.com>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Wed, 27 Nov 2019 02:41:45 +0530
Message-ID: <CACi5LpPosB9TbVBoG8CVdax0e7pJjpZQUQF2ZB3LciNohXRraQ@mail.gmail.com>
Subject: Re: kexec-tools/vmcore-demsg: No program header covering vaddr
 0xffff000be7a00000found kexec bug?
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
To: Prabhakar Kushwaha <prabhakar.pkin@gmail.com>
Cc: Prabhakar Kushwaha <pkushwaha@marvell.com>, kexec mailing list <kexec@lists.infradead.org>, Ganapatrao Prabhakerrao Kulkarni <gkulkarni@marvell.com>

Hi Prabhakar,

On Tue, Nov 26, 2019 at 1:04 PM Prabhakar Kushwaha
<prabhakar.pkin@gmail.com> wrote:
>
> Hi All,
>
> I am facing issue below error with latest kexec-tools/vmcore-demsg tools.
>
> $ ./build/sbin/vmcore-dmesg /proc/vmcore
> No program header covering vaddr 0xffff000be7a00000found kexec bug?
>
> I am testing on AARM64 platform with following git repos.
> A) kexec tools:
> https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git
> top commit: bd077966e2b9041c (kexec-tools: Fix conversion overflow
> when compiling on 32-bit platforms)
>
> B) Linux:git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> top commit: af42d3466bdc8f3980 (Linux 5.4-rc8)
>
> I am seeing similar issue in past also in couple of discussions. has
> it not fixed earlier or it keep arises with time to time
>
> Please suggest.

Thanks for reporting the issue.
I think the issue with the latest ARM64 kernel and kexec-tools is the
same as the makedumpfile, i.e. the PAGE_OFFSET calculation needs to be
dynamically done for 52-bit VA_BITS correctly as well.

I think the VA_BITS calculation via _stext symbol will not work well
for 52-bit case, because the 52nd and 48th bit are both set in such a
case  (I already have a conversation going on with the arm64
maintainers on how to get around this issue).

Until we agree on a formal approach with the arm64 miantainer, I will
try to send a patch (soon) to fix this kexec-tools issue in a generic
way (for 52-bit and 48-bit VA_BITS values).

Regards,
Bhupesh


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
