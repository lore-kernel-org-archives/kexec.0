Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VRFqn-0006et-3g
 for kexec@lists.infradead.org; Wed, 02 Oct 2013 06:23:58 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH] makedumpfile: fix max_mapnr issue on system has over
 44-bit addressing
Date: Wed, 2 Oct 2013 06:20:33 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE971B4921@BPXM01GP.gisp.nec.co.jp>
References: <20130924124931.14715.24507.stgit@k.asiapacific.hpqcorp.net>
 <52422FCF.1030206@jp.fujitsu.com> <52429BF1.3050303@hp.com>
 <5242A13B.6000907@jp.fujitsu.com> <5242A4BF.5090903@hp.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "jingbai.ma@hp.com" <jingbai.ma@hp.com>
Cc: "bhe@redhat.com" <bhe@redhat.com>, Daisuke Nishimura <nishimura@mxp.nes.nec.co.jp>, Minoru Usui <usui@mxm.nes.nec.co.jp>, Masaki Tachibana <tachibana@mxm.nes.nec.co.jp>, "lisa.mitchell@hp.com" <lisa.mitchell@hp.com>, "ruyang@redhat.com" <ruyang@redhat.com>, "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>, "anderson@redhat.com" <anderson@redhat.com>, "chaowang@redhat.com" <chaowang@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "vgoyal@redhat.com" <vgoyal@redhat.com>, "crash-utility@redhat.com" <crash-utility@redhat.com>

Hello Jingbai,

I have a additional comment.

(2013/09/25 17:54), Jingbai Ma wrote:
> On 09/25/2013 04:39 PM, HATAYAMA Daisuke wrote:
>> (2013/09/25 17:16), Jingbai Ma wrote:
>> <cut>
> @@ -790,7 +794,7 @@ get_kdump_compressed_header_info(char *filename)
>       DEBUG_MSG("  block_size       : %d\n", dh.block_size);
>       DEBUG_MSG("  sub_hdr_size     : %d\n", dh.sub_hdr_size);
>       DEBUG_MSG("  bitmap_blocks    : %d\n", dh.bitmap_blocks);
> -     DEBUG_MSG("  max_mapnr        : 0x%x\n", dh.max_mapnr);
> +     DEBUG_MSG("  max_mapnr(32bit) : 0x%x\n", dh.max_mapnr);
>       DEBUG_MSG("  total_ram_blocks : %d\n", dh.total_ram_blocks);
>       DEBUG_MSG("  device_blocks    : %d\n", dh.device_blocks);
>       DEBUG_MSG("  written_blocks   : %d\n", dh.written_blocks);
> @@ -802,6 +806,7 @@ get_kdump_compressed_header_info(char *filename)
>       DEBUG_MSG("  split            : %d\n", kh.split);
>       DEBUG_MSG("  start_pfn        : 0x%lx\n", kh.start_pfn);
>       DEBUG_MSG("  end_pfn          : 0x%lx\n", kh.end_pfn);
> +     DEBUG_MSG("  max_mapnr(64bit) : 0x%lx\n", kh.max_mapnr);

max_mapnr(64bit) will be included only in header_version 6 and later,
but your code shows that in any version.
I think it's better to change the code like below:

diff --git a/makedumpfile.c b/makedumpfile.c
index 069a903..6c20e88 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -847,6 +847,10 @@ get_kdump_compressed_header_info(char *filename)
  				(unsigned long long)kh.offset_eraseinfo);
  		DEBUG_MSG("  size_eraseinfo   : 0x%ld\n", kh.size_eraseinfo);
  	}
+	if (dh.header_version >= 6) {
+		/* A dumpfile contains full 64bit max_mapnr. */
+		DEBUG_MSG("  max_mapnr(64bit) : 0x%llx\n", kh.max_mapnr);
+	}
  	return TRUE;
  error:
  	free(info->dh_memory);


Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
