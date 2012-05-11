Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1SSt3l-00076j-Ap
 for kexec@lists.infradead.org; Fri, 11 May 2012 16:51:18 +0000
Date: Fri, 11 May 2012 12:51:12 -0400 (EDT)
From: Dave Anderson <anderson@redhat.com>
Subject: Re: [RESEND][PATCH] crash: Add LZO Compression Support
Message-ID: <196c935b-cbb7-43b9-b5ba-3c2324fae29f@zmail15.collab.prod.int.phx2.redhat.com>
In-Reply-To: <4FAC8D14.1010303@jp.fujitsu.com>
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
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: kumagai-atsushi@mxc.nes.nec.co.jp, kexec@lists.infradead.org, crash-utility@redhat.com



----- Original Message -----
> I'm sorry that I wrongly sended the previous mail in html format. I
> re-send the mail.
> 
> ==
> Hello Dave,
> 
> This is LZO patch for crash utility. makedumpfile will support LZO
> compression in version 1.4.4, and it will be released this or next
> month.
> 
> LZO patch for makedumpfile is here:
> 
> [PATCH makedumpfile 0/2] LZO Compression Support
> http://lists.infradead.org/pipermail/kexec/2012-February/006075.html
> 
> Thanks.
> HATAYAMA, Daisuke
 
Hello Daisuke,

I made one small change, replacing the dd->lzo_supported integer
with an LZO_SUPPORTED bit in dd->flags, and if set, display it in
the __diskdump_memory_dump() function.

Queued for crash-6.0.7. 

Thanks,
  Dave
 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
