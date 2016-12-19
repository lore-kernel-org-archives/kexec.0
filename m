Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cIsZB-0003sR-A0
 for kexec@lists.infradead.org; Mon, 19 Dec 2016 07:41:02 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [PATCH 1/2] eppic: vhost_net_buffers - Adopt to struct sk_buff
 changes
Date: Mon, 19 Dec 2016 07:34:45 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701E8CA8E@BPXM01GP.gisp.nec.co.jp>
References: <a2161c027dba53f21476f3bc283fae8700778a74.1481721378.git.kamalesh@linux.vnet.ibm.com>
In-Reply-To: <a2161c027dba53f21476f3bc283fae8700778a74.1481721378.git.kamalesh@linux.vnet.ibm.com>
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
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello Kamalesh,

Thanks for taking care of the scripts.

The current scripts are created based on the same kernel version:

   ===================================
    Eppic scripts README
   ==================================
   
   The eppic scripts are based on the fedora 19 kernel. 

So if you update a part of the scripts, the target kernel version of
them will be complex and confusing.
I don't think we need to update these scripts since they are just sample,
the purpose is to tell users how to write a script.


Thanks,
Atsushi Kumagai

>Linux kernel commit 56b174256b69 ("net: add rbnode to struct sk_buff"),
>moves sk_buff->next into an union of sk_buff->{next/prev/tstamp/rb_node}.
>Introduce this structure member change, while traversing the socket
>buffer list.
>
>Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
>---
> eppic_scripts/vhost_net_buffers.c | 11 ++++++++---
> 1 file changed, 8 insertions(+), 3 deletions(-)
>
>diff --git a/eppic_scripts/vhost_net_buffers.c b/eppic_scripts/vhost_net_buffers.c
>index 39ae595..1260acb 100644
>--- a/eppic_scripts/vhost_net_buffers.c
>+++ b/eppic_scripts/vhost_net_buffers.c
>@@ -45,7 +45,10 @@ vhost_net(struct vhost_net *net)
> 				memset((char *)&(buff->data_len), 'L', 0x4);
> 			}
>
>-			next = buff->next;
>+			/*
>+			 * .next is the first entry.
>+			 */
>+			next = (struct sk_buff *)(unsigned long)*buff;
> 		}
>
> 		head = (struct sk_buff_head *)&(sk->sk_write_queue);
>@@ -60,8 +63,10 @@ vhost_net(struct vhost_net *net)
> 				memset((char *)&(buff->data_len), 'L', 0x4);
> 			}
>
>-			next = buff->next;
>-
>+			/*
>+			 * .next is the first entry.
>+			 */
>+			next = (struct sk_buff *)(unsigned long)*buff;
> 		}
> 	}
> }
>--
>2.7.4
>
>
>_______________________________________________
>kexec mailing list
>kexec@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
