Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-io1-f66.google.com ([209.85.166.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkJhj-00068G-U6
 for kexec@lists.infradead.org; Fri, 18 Jan 2019 02:16:21 +0000
Received: by mail-io1-f66.google.com with SMTP id r200so9489308iod.11
 for <kexec@lists.infradead.org>; Thu, 17 Jan 2019 18:16:16 -0800 (PST)
MIME-Version: 1.0
References: <20190116101654.7288-1-kasong@redhat.com>
 <1547773684.4026.10.camel@linux.ibm.com>
 <20190118013530.GA2814@dhcp-128-65.nay.redhat.com>
 <20190118020006.GB2814@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20190118020006.GB2814@dhcp-128-65.nay.redhat.com>
From: Kairui Song <kasong@redhat.com>
Date: Fri, 18 Jan 2019 10:16:04 +0800
Message-ID: <CACPcB9ftKKp_uZf=kN86K2xqbVmaNfs97iyc4zPA_7d7FfL9eg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] let kexec_file_load use platform keyring to verify
 the kernel image
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
To: Dave Young <dyoung@redhat.com>
Cc: jwboyer@fedoraproject.org, Eric Biggers <ebiggers@google.com>, nayna@linux.ibm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, jmorris@namei.org, David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org, linux-integrity <linux-integrity@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, bauerman@linux.ibm.com, serge@hallyn.com

On Fri, Jan 18, 2019 at 10:00 AM Dave Young <dyoung@redhat.com> wrote:
>
> On 01/18/19 at 09:35am, Dave Young wrote:
> > On 01/17/19 at 08:08pm, Mimi Zohar wrote:
> > > On Wed, 2019-01-16 at 18:16 +0800, Kairui Song wrote:
> > > > This patch series adds a .platform_trusted_keys in system_keyring as the
> > > > reference to .platform keyring in integrity subsystem, when platform
> > > > keyring is being initialized it will be updated. So other component could
> > > > use this keyring as well.
> > >
> > > Remove "other component could use ...".
> > > >
> > > > This patch series also let kexec_file_load use platform keyring as fall
> > > > back if it failed to verify the image against secondary keyring, make it
> > > > possible to load kernel signed by third part key if third party key is
> > > > imported in the firmware.
> > >
> > > This is the only reason for these patches.  Please remove "also".
> > >
> > > >
> > > > After this patch kexec_file_load will be able to verify a signed PE
> > > > bzImage using keys in platform keyring.
> > > >
> > > > Tested in a VM with locally signed kernel with pesign and imported the
> > > > cert to EFI's MokList variable.
> > >
> > > It's taken so long for me to review/test this patch set due to a
> > > regression in sanity_check_segment_list(), introduced somewhere
> > > between 4.20 and 5.0.0-rc1.  The sgement overlap test - "if ((mend >
> > > pstart) && (mstart < pend))" - fails, returning a -EINVAL.
> > >
> > > Is anyone else seeing this?
> >
> > Mimi, should be this issue?  I have sent a fix for that.
> > https://lore.kernel.org/lkml/20181228011247.GA9999@dhcp-128-65.nay.redhat.com/
>
> Hi, Kairui, I think you should know this while working on this series,
> It is good to mention the test dependency in cover letter so that reviewers
> can save time.
>
> BTW, Boris took it in tip already:
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=993a110319a4a60aadbd02f6defdebe048f7773b
>

Hi, thanks for the suggestion, I did apply your patch to avoid the
failure. Will add such info next time.

Will send out V4 and update commit message as suggested by Mimi


--
Best Regards,
Kairui Song

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
