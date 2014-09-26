Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e06smtp10.uk.ibm.com ([195.75.94.106])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XXQhw-0000Ys-9T
 for kexec@lists.infradead.org; Fri, 26 Sep 2014 08:16:52 +0000
Received: from /spool/local
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Fri, 26 Sep 2014 09:16:26 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id DAD8D2190043
 for <kexec@lists.infradead.org>; Fri, 26 Sep 2014 09:16:00 +0100 (BST)
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com
 [9.149.37.250])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8Q8GL0R16646234
 for <kexec@lists.infradead.org>; Fri, 26 Sep 2014 08:16:21 GMT
Received: from d06av09.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8Q8GLjP030817
 for <kexec@lists.infradead.org>; Fri, 26 Sep 2014 02:16:21 -0600
Date: Fri, 26 Sep 2014 10:16:19 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: makedumpfile-1.5.7: Compile warnings on archs without
 get_versiondep_info()
Message-ID: <20140926101619.56f90824@holzheu>
Mime-Version: 1.0
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
To: kexec@lists.infradead.org, kumagai-atsushi@mxc.nes.nec.co.jp

I just noticed that makedumpfile-1.5.7 produces warnings
on s390x and probably all other archs that have not defined
get_versiondep_info():

elf_info.c: In function 'get_kcore_dump_loads':
elf_info.c:856:27: warning: unused variable 'p' [-Wunused-variable]
   struct pt_load_segment *p = &pt_loads[i];
                     
      ^
In file included from makedumpfile.h:41:0,
                 from makedumpfile.c:16:
makedumpfile.c: In function 'get_page_offset':
common.h:19:15: warning: statement with no effect [-Wunused-value]
 #define TRUE  (1)
               ^
makedumpfile.h:821:31: note: in expansion of macro 'TRUE'
 #define get_versiondep_info() TRUE
                               ^
makedumpfile.c:9240:2: note: in expansion of macro 'get_versiondep_info'
  get_versiondep_info();

Best Regards
Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
