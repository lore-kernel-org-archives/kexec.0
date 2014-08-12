Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XH8gX-0000aU-1w
 for kexec@lists.infradead.org; Tue, 12 Aug 2014 09:48:05 +0000
Date: Tue, 12 Aug 2014 17:46:23 +0800
From: "bhe@redhat.com" <bhe@redhat.com>
Subject: Re: [Patch v3 3/7] preparation functions for parsing vmcoreinfo
Message-ID: <20140812094623.GB4887@dhcp-16-105.nay.redhat.com>
References: <1406535606-16303-1-git-send-email-bhe@redhat.com>
 <1406535606-16303-4-git-send-email-bhe@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE97246615@BPXM01GP.gisp.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE97246615@BPXM01GP.gisp.nec.co.jp>
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
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "vgoyal@redhat.com" <vgoyal@redhat.com>

On 08/01/14 at 07:12am, Atsushi Kumagai wrote:
> >diff --git a/makedumpfile.c b/makedumpfile.c
> >index 220570e..78aa7a5 100644
> >--- a/makedumpfile.c
> >+++ b/makedumpfile.c
> >@@ -681,6 +681,10 @@ get_kernel_version(char *release)
> > 	int32_t version;
> > 	long maj, min, rel;
> > 	char *start, *end;
> >+	static int done = 0;
> >+
> >+	if (done)
> >+		return info->kernel_version;
> 
> This function just convert the argument as string into
> a number, it shouldn't be affected by external factors.
> 
> You should use info->kernel_version in the caller side if
> you want to avoid duplicate calling of this function, but
> I think it's unnecessary since this function is small.

In show_mem_usage() implementaion, the page_offset is needed before
initial() calling because the dumpable elf program loads have ot be
prepared before that. However in current commited code, the page_offset
is got in initial() when call check_release().

So I have to get it in advance by this way. Then the
get_kernel_version() can be reused in this way. Anyway, by this I
needn't change the code in initial().

If use info->kernel_version directly before initial() calling, it's
still zero.

> 
> >
> > 	/*
> > 	 * This method checks that vmlinux and vmcore are same kernel version.
> >@@ -706,6 +710,9 @@ get_kernel_version(char *release)
> > 		MSG("The kernel version is not supported.\n");
> > 		MSG("The created dumpfile may be incomplete.\n");
> > 	}
> >+
> >+	done = 1;
> >+
> > 	return version;
> > }
> >
> >@@ -9062,6 +9069,22 @@ int is_crashkernel_mem_reserved(void)
> >         return !!crash_reserved_mem_nr;
> > }
> >
> >+static int get_page_offset()
> >+{
> >+#ifdef __x86_64__
> >+	struct utsname utsname;
> >+	if (uname(&utsname)) {
> >+		ERRMSG("Cannot get name and information about current kernel : %s", strerror(errno));
> >+		return FALSE;
> >+	}
> >+
> >+	info->kernel_version = get_kernel_version(utsname.release);
> >+	get_versiondep_info_x86_64();
> >+#endif /* x86_64 */
> 
> You should replace get_versiondep_info_x86_64() with get_versiondep_info()
> to get rid of #ifdef.
> #ifdef is messy, I don't want to use it if possible.

Sure, will do.

> 
> 
> Thanks
> Atsushi Kumagai.
> 
> >+
> >+	return TRUE;
> >+}
> >+
> > static struct option longopts[] = {
> > 	{"split", no_argument, NULL, OPT_SPLIT},
> > 	{"reassemble", no_argument, NULL, OPT_REASSEMBLE},
> >--
> >1.8.5.3
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
