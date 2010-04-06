Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]
	helo=mx01.colomx.prod.int.phx2.redhat.com)
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1Nz9n4-0007ia-KA
	for kexec@lists.infradead.org; Tue, 06 Apr 2010 14:30:07 +0000
Date: Tue, 6 Apr 2010 10:30:03 -0400 (EDT)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <895782128.129731270564203180.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1256260268.128691270563908286.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
Subject: Re: [crash][patch] handle !SPARSEMEM_EX properly
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Daisuke Nishimura <nishimura@mxp.nes.nec.co.jp>
Cc: Neil Horman <nhorman@redhat.com>, kexec@lists.infradead.org, crash-utility@redhat.com


----- "Daisuke Nishimura" <nishimura@mxp.nes.nec.co.jp> wrote:

> In !SPARSEMEM_EX case, the symbol mem_section points a array of struct mem_section,
> doesn't point a array of pointer to mem_section[], so I think the
> check:
> 
> 	if ((mem_sec[SECTION_NR_TO_ROOT(nr)] == 0) || 
> 	    !IS_KVADDR(mem_sec[SECTION_NR_TO_ROOT(nr)]))
> 		return 0;
> 
> in nr_to_section() is not a valid check in this case.
> 
> To make the matters worse, if CONFIG_CGROUP_MEM_RES_CTLR is enabled, the end of
> struct mem_section is padded with 0.
> 
> So, reading mem_section by "rd" will look like:
> 
> 	crash> rd mem_section 128
> 	c08b71e0:  c9002003 c9001200 f7000000 00000000   . ..............
> 	c08b71f0:  c9002003 c9001260 f6980000 00000000   . ..`...........
> 	c08b7200:  c9002003 c90012c0 f6300000 00000000   . ........0.....
> 	c08b7210:  c9002003 c9001320 f5c80000 00000000   . .. ...........
> 	...
> 
> This means nr_to_section() will return 0 when "nr" is 3,7,11,... because it meets
> the condition(mem_sec[SECTION_NR_TO_ROOT(nr)] == mem_sec[nr] == 0).
> 
> As a result, mem_map for section 3,7,11,... cannot be handled properly.
> Actually, "kmem -n" doesn't show a mem_map for them.
> 
> 	crash> kmem -n
> 	...
> 	NR  SECTION   CODED_MEM_MAP  MEM_MAP   PFN
> 	 0  c08b71e0  c9002000  c9002000  0
> 	 1  c08b71f0  c9002000  c9402000  131072
> 	 2  c08b7200  c9002000  c9802000  262144
> 	 4  c08b7220  c9002000  ca002000  524288
> 	 5  c08b7230  c9002000  ca402000  655360
> 	 6  c08b7240  c9002000  ca802000  786432
> 	 8  c08b7260  c8c02000  cac02000  1048576
> 	 9  c08b7270  c8c02000  cb002000  1179648
> 	10  c08b7280  c8c02000  cb402000  1310720
> 	12  c08b72a0  c8c02000  cbc02000  1572864
> 	...
> 
> This patch is a fix for this problem. nr_to_section() will check "addr" by
> IS_KVADDR() later anyway, so this patch just removes the problematic check.

I cannot recall exactly why that sanity check was put in place,
but it's clear that it only applies for CONFIG_SPARSEMEM_EXTREME 
kernels.  Thanks for catching that.

However, at least theoretically, the s390/s390x architectures 
could be configured with CONFIG_SPARSEMEM_EXTREME, and in that
case "0" is considered a legitimate kernel virtual address.  
But it would never be a legitimate mem_sec[] address.  

So -- out of sheer paranoia -- instead of removing the check
completely, I will move it further down inside the subsequent 
"if (IS_SPARSEMEM_EX())" section:

--- memory.c    5 Apr 2010 19:04:29 -0000       1.217
+++ memory.c    6 Apr 2010 14:23:21 -0000
@@ -13058,14 +13058,13 @@
                }
        }
 
-       if ((mem_sec[SECTION_NR_TO_ROOT(nr)] == 0) || 
-           !IS_KVADDR(mem_sec[SECTION_NR_TO_ROOT(nr)]))
-               return 0;
-
-       if (IS_SPARSEMEM_EX())
+       if (IS_SPARSEMEM_EX()) {
+               if ((mem_sec[SECTION_NR_TO_ROOT(nr)] == 0) || 
+                   !IS_KVADDR(mem_sec[SECTION_NR_TO_ROOT(nr)]))
+                       return 0;
                addr = mem_sec[SECTION_NR_TO_ROOT(nr)] + 
                    (nr & SECTION_ROOT_MASK()) * SIZE(mem_section);
-       else
+       } else
                addr = symbol_value("mem_section") +
                    (SECTIONS_PER_ROOT() * SECTION_NR_TO_ROOT(nr) +
                        (nr & SECTION_ROOT_MASK())) * SIZE(mem_section);


Thanks,
  Dave
 
> Signed-off-by: Daisuke Nishimura <nishimura@mxp.nes.nec.co.jp>
> ---
> diff -uprN crash-5.0.2.orig/memory.c crash-5.0.2/memory.c
> --- crash-5.0.2.orig/memory.c	2010-04-05 16:08:52.000000000 +0900
> +++ crash-5.0.2/memory.c	2010-04-06 09:56:43.000000000 +0900
> @@ -13030,10 +13030,6 @@ nr_to_section(ulong nr)
>  		}
>  	}
>  
> -	if ((mem_sec[SECTION_NR_TO_ROOT(nr)] == 0) || 
> -	    !IS_KVADDR(mem_sec[SECTION_NR_TO_ROOT(nr)]))
> -		return 0;
> -
>  	if (IS_SPARSEMEM_EX())
>  		addr = mem_sec[SECTION_NR_TO_ROOT(nr)] + 
>  		    (nr & SECTION_ROOT_MASK()) * SIZE(mem_section);

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
