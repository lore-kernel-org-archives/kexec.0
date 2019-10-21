Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]
 helo=us-smtp-delivery-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iMco5-00086q-80
 for kexec@lists.infradead.org; Mon, 21 Oct 2019 18:53:30 +0000
Received: by mail-lj1-f199.google.com with SMTP id m22so2598145ljj.6
 for <kexec@lists.infradead.org>; Mon, 21 Oct 2019 11:53:21 -0700 (PDT)
MIME-Version: 1.0
References: <1C379272-3B10-432C-8A83-8F3008CEE87F@oracle.com>
In-Reply-To: <1C379272-3B10-432C-8A83-8F3008CEE87F@oracle.com>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Tue, 22 Oct 2019 00:23:07 +0530
Message-ID: <CACi5LpM9eN7XuFRi-BapvGNSfu8GgDPTi0BRG9WT4E_nJkzwfw@mail.gmail.com>
Subject: Re: Makedumpfile help for 5.4.0.rc3 : Arm
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
To: John Donnelly <john.p.donnelly@oracle.com>
Cc: kexec mailing list <kexec@lists.infradead.org>

Hello John,

On Mon, Oct 21, 2019 at 9:39 PM John Donnelly
<john.p.donnelly@oracle.com> wrote:
>
>
>
> Hello,
>
>
> Kazuhito Hagio asked me to share my test results on this patch for makedumpfile :
>
>
> https://sourceforge.net/p/makedumpfile/code/ci/7bdb468c2c99dd780c9a5321f93c79cbfdce2527/
>
> And I was successfully able to get vmcore dumps on vmlinuz-5.3.6 and 5.4.0-rc3 Intel ( x86-64) kernels.
>
> I am still having difficulties getting vmcores on 5.4.0.rc3   Arm kernels with this update to makedumpfile.
>
> I get this message;
>
>
> Buffer size for the cyclic mode: 3145728
> va_bits      : 47
> page_offset  : ffffc00000000000
> calculate_plat_config: PAGE SIZE 0x10000 and VA Bits 47 not supported
> get_machdep_info_arm64: Can't determine platform config values
>
> makedumpfile Failed.
>
>
> Any suggestions welcomed

I am working on the changes in the vmcoreinfo after the 52-bit VA
changes from Steve were accepted in Linux 5.4-rc1 ("Support for 52-bit
virtual addressing in kernel space").

The suggestions during the last set of reviews (my v3 patchset) was to
introduce arch specific details like TCR_EL1.TxSZ in the vmcoreinfo
and also to wait for the 52-bit changes to make way upstream (as I
raised a couple of issues/kernel panic issues) earlier with the 52-bit
VA changes from Steve.

I plan to send out the v4 patchset later this week (and will Cc you so
that you can test the same).

Thanks,
Bhupesh


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
