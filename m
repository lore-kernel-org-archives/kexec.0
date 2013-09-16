Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VLejk-0006y5-LS
 for kexec@lists.infradead.org; Mon, 16 Sep 2013 19:45:34 +0000
Date: Mon, 16 Sep 2013 15:45:04 -0400 (EDT)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <131560856.13730586.1379360704169.JavaMail.root@redhat.com>
In-Reply-To: <50924626.13720007.1379359322944.JavaMail.root@redhat.com>
Subject: [BUG] [compressed kdump / SADUMP] makedumpfile header truncation error
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
To: kexec@lists.infradead.org
Cc: Baoquan He <bhe@redhat.com>, Daisuke Nishimura <nishimura@mxp.nes.nec.co.jp>, usui@mxm.nes.nec.co.jp, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, lisa mitchell <lisa.mitchell@hp.com>, RuiRui Yang <ruyang@redhat.com>, Masaki Tachibana <tachibana@mxm.nes.nec.co.jp>, kumagai-atsushi <kumagai-atsushi@mxc.nes.nec.co.jp>, WANG Chao <chaowang@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, "Discussion list for crash utility usage,
 maintenance and development" <crash-utility@redhat.com>


Recent testing on very large memory systems dictates that an
update is required for the compressed kdump header generated
by makedumpfile.

The dumpfile header has this field, which was inherited from 
the old "diskdump" facility:

 struct disk_dump_header {
 ...
        unsigned int            max_mapnr;      /* = max_mapnr */
 ...

and which, among other things, is used by the crash utility as a
delimiter to determine whether a physical address read request is
legitimate.  And obviously the field cannot handle PFN values greater
than 32-bits.

The makedumpfile source code does have its own max_mapnr representation
in its DumpInfo structure in "makedumpfile.h":

 struct DumpInfo {
 ...
        unsigned long long      max_mapnr;   /* number of page descriptor */
 ...

But in its "diskdump_mod.h" file, it carries forward the old diskdump 
header format, which has the 32-bit field:

 struct disk_dump_header {
 ...
        unsigned int            max_mapnr;      /* = max_mapnr */
 ...

And here in "makedumpfile.c", the inadvertent truncation occurs
when the PFN is greater than 32-bits:

 int
 write_kdump_header(void)
 {
 ...
        dh->max_mapnr      = info->max_mapnr;
 ...

The 32-bit field has also been carried forward into the SADUMP header
as well, which has this in "sadump_mod.h":

 struct sadump_header {
	...
        uint32_t max_mapnr;     /* = max_mapnr */	
	...

And when these header structures change, the crash utility will need 
to be changed accordingly.

Preferably for backwards-compatibility, a new header_version can be 
created, with the new expanded field located in the kdump_sub_header
so that the original base structure can remain as-is.  But I leave that
up to the maintainers.

Thanks,
  Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
