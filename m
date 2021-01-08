Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-eopbgr1410049.outbound.protection.outlook.com
 ([40.107.141.49] helo=JPN01-OS2-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kxog9-0003rT-M1
 for kexec@lists.infradead.org; Fri, 08 Jan 2021 10:07:35 +0000
From: =?iso-2022-jp?B?SEFHSU8gS0FaVUhJVE8oGyRCR2tIeCEhMGw/ThsoQik=?=
 <k-hagio-ab@nec.com>
Subject: RE: [PATCH v3 1/1] kdump: append uts_namespace.name offset to
 VMCOREINFO
Date: Fri, 8 Jan 2021 10:07:07 +0000
Message-ID: <OSBPR01MB1991DBFA6C4BD6818947EF6BDDAE0@OSBPR01MB1991.jpnprd01.prod.outlook.com>
References: <20200930102328.396488-1-egorenar@linux.ibm.com>
 <20210108033248.GA4959@MiWiFi-R3L-srv>
In-Reply-To: <20210108033248.GA4959@MiWiFi-R3L-srv>
Content-Language: ja-JP
MIME-Version: 1.0
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
To: Baoquan He <bhe@redhat.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc: "lijiang@redhat.com" <lijiang@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alexander Egorenkov <egorenar@linux.ibm.com>, "ktkhai@virtuozzo.com" <ktkhai@virtuozzo.com>, "ebiederm@xmission.com" <ebiederm@xmission.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "dyoung@redhat.com" <dyoung@redhat.com>, "christian.brauner@ubuntu.com" <christian.brauner@ubuntu.com>, "vgoyal@redhat.com" <vgoyal@redhat.com>, "keescook@chromium.org" <keescook@chromium.org>

Hi Baoquan,

-----Original Message-----
> On 09/30/20 at 12:23pm, Alexander Egorenkov wrote:
> > The offset of the field 'init_uts_ns.name' has changed
> > since commit 9a56493f6942 ("uts: Use generic ns_common::count").
> 
> This patch is merged into 5.11-rc1, but we met the makedumpfile failure
> of kdump test case in 5.10.0 kernel. Should affect 5.9 too since
> commit 9a56493f6942 is merged into 5.9-rc2.

Hmm, commit 9a56493f6942 should have been merged into 5.11-rc1
together with commit ca4a9241cc5e.

Does your makedumpfile have the following patch?
https://github.com/makedumpfile/makedumpfile/commit/54aec3878b3f91341e6bc735eda158cca5c54ec9

or am I missing something?

Thanks,
Kazu

> 
> Below tag and CC should have been added into patch when posted.
> 
> Fixes: commit 9a56493f6942 ("uts: Use generic ns_common::count")
> Cc: <stable@vger.kernel.org>
> 
> Hi Greg,
> 
> Do we still have chance to make it added into stable?
> 
> Thanks
> Baoquan
> 
> >
> > Link: https://lore.kernel.org/r/159644978167.604812.1773586504374412107.stgit@localhost.localdomain
> >
> > Make the offset of the field 'uts_namespace.name' available
> > in VMCOREINFO because tools like 'crash-utility' and
> > 'makedumpfile' must be able to read it from crash dumps.
> >
> > Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>
> > ---
> >
> > v2 -> v3:
> >  * Added documentation to vmcoreinfo.rst
> >  * Use the short form of the commit reference
> >
> > v1 -> v2:
> >  * Improved commit message
> >  * Added link to the discussion of the uts namespace changes
> >
> >  Documentation/admin-guide/kdump/vmcoreinfo.rst | 6 ++++++
> >  kernel/crash_core.c                            | 1 +
> >  2 files changed, 7 insertions(+)
> >
> > diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst
> b/Documentation/admin-guide/kdump/vmcoreinfo.rst
> > index e44a6c01f336..3861a25faae1 100644
> > --- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
> > +++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
> > @@ -39,6 +39,12 @@ call.
> >  User-space tools can get the kernel name, host name, kernel release
> >  number, kernel version, architecture name and OS type from it.
> >
> > +(uts_namespace, name)
> > +---------------------
> > +
> > +Offset of the name's member. Crash Utility and Makedumpfile get
> > +the start address of the init_uts_ns.name from this.
> > +
> >  node_online_map
> >  ---------------
> >
> > diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> > index 106e4500fd53..173fdc261882 100644
> > --- a/kernel/crash_core.c
> > +++ b/kernel/crash_core.c
> > @@ -447,6 +447,7 @@ static int __init crash_save_vmcoreinfo_init(void)
> >  	VMCOREINFO_PAGESIZE(PAGE_SIZE);
> >
> >  	VMCOREINFO_SYMBOL(init_uts_ns);
> > +	VMCOREINFO_OFFSET(uts_namespace, name);
> >  	VMCOREINFO_SYMBOL(node_online_map);
> >  #ifdef CONFIG_MMU
> >  	VMCOREINFO_SYMBOL_ARRAY(swapper_pg_dir);
> > --
> > 2.26.2
> >
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
