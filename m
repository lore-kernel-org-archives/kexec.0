Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1X9rWZ-0004PW-3C
 for kexec@lists.infradead.org; Wed, 23 Jul 2014 08:03:46 +0000
Date: Wed, 23 Jul 2014 16:01:55 +0800
From: "bhe@redhat.com" <bhe@redhat.com>
Subject: Re: [PATCH v2] add a new interface to show the memory usage of 1st
 kernel
Message-ID: <20140723080155.GJ11399@dhcp-16-105.nay.redhat.com>
References: <1405062964-11406-1-git-send-email-bhe@redhat.com>
 <1405062964-11406-7-git-send-email-bhe@redhat.com>
 <20140711072748.GB1547@dhcp-17-102.nay.redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE97243468@BPXM01GP.gisp.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE97243468@BPXM01GP.gisp.nec.co.jp>
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

On 07/23/14 at 07:20am, Atsushi Kumagai wrote:
> >@@ -9254,6 +9314,9 @@ main(int argc, char *argv[])
> > 		case OPT_DUMP_DMESG:
> > 			info->flag_dmesg = 1;
> > 			break;
> >+		case OPT_MEM_USAGE:
> >+                       info->flag_mem_usage = 1;
> >+                       break;
> > 		case OPT_COMPRESS_SNAPPY:
> > 			info->flag_compress = DUMP_DH_COMPRESSED_SNAPPY;
> > 			break;
> >@@ -9394,6 +9457,18 @@ main(int argc, char *argv[])
> >
> > 		MSG("\n");
> > 		MSG("The dmesg log is saved to %s.\n", info->name_dumpfile);
> >+	} else if (info->flag_mem_usage) {
> >+		if (!check_param_for_creating_dumpfile(argc, argv)) {
> >+			MSG("Commandline parameter is invalid.\n");
> >+			MSG("Try `makedumpfile --help' for more information.\n");
> >+			goto out;
> >+		}
> 
> There is no description of this feature, could you add them
> into the help message and the man page ?

Thanks for your review. Will add them.

Thanks
Baoquan

> 
> 
> Thanks
> Atsushi Kumagai
> 
> >+
> >+		if (!show_mem_usage())
> >+			goto out;
> >+
> >+		MSG("\n");
> >+		MSG("Showing page number of memory in different use successfully.\n");
> > 	} else {
> > 		if (!check_param_for_creating_dumpfile(argc, argv)) {
> > 			MSG("Commandline parameter is invalid.\n");
> >diff --git a/makedumpfile.h b/makedumpfile.h
> >index 7ffa1ee..7b537c7 100644
> >--- a/makedumpfile.h
> >+++ b/makedumpfile.h
> >@@ -910,6 +910,7 @@ struct DumpInfo {
> > 	int		flag_force;	     /* overwrite existing stuff */
> > 	int		flag_exclude_xen_dom;/* exclude Domain-U from xen-kdump */
> > 	int             flag_dmesg;          /* dump the dmesg log out of the vmcore file */
> >+	int             flag_mem_usage;  /*show the page number of memory in different use*/
> > 	int		flag_use_printk_log; /* did we read printk_log symbol name? */
> > 	int		flag_nospace;	     /* the flag of "No space on device" error */
> > 	int		flag_vmemmap;        /* kernel supports vmemmap address space */
> >@@ -1771,6 +1772,7 @@ struct elf_prstatus {
> > #define OPT_CYCLIC_BUFFER       OPT_START+11
> > #define OPT_EPPIC               OPT_START+12
> > #define OPT_NON_MMAP            OPT_START+13
> >+#define OPT_MEM_USAGE            OPT_START+14
> >
> > /*
> >  * Function Prototype.
> >--
> >1.9.3
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
