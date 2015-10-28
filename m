Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZrLGV-0003OT-FF
 for kexec@lists.infradead.org; Wed, 28 Oct 2015 07:35:23 +0000
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
 (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
 by mx1.redhat.com (Postfix) with ESMTPS id AEF9392471
 for <kexec@lists.infradead.org>; Wed, 28 Oct 2015 07:35:01 +0000 (UTC)
Message-ID: <1446017698.3618.0.camel@redhat.com>
Subject: Re: [PATCH] vmcore-dmesg: do not use logged_chars as dmesg length
From: Dangyi Liu <dliu@redhat.com>
Date: Wed, 28 Oct 2015 15:34:58 +0800
In-Reply-To: <20151028070618.GD30645@dhcp-128-73.nay.redhat.com>
References: <1446010707-7527-1-git-send-email-dliu@redhat.com>
 <20151028070618.GD30645@dhcp-128-73.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: kexec@lists.infradead.org

On Wed, 2015-10-28 at 15:06 +0800, Dave Young wrote:
> Please use /* */ style comment, also it is not a bug because
> In theroy it is ok for only showing later dmesg after dmesg -c in
> current code.
> But crash utils and vmcore-dmesg in new log buf format support
> dumping all
> kernel messages which includes the part before dmesg -c. It is not
> harm to
> keep same behavior with them.
> 
> So the comment should be changed to something like below:
> /*
>  * To collect full dmesg including the part before `dmesg -c` is
> useful for
>  * later debugging. Use same logic as what crash utility is using.
>  */

OK, I'll update the comment and send again.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
