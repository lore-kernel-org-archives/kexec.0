Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UP3Xy-00072J-1R
 for kexec@lists.infradead.org; Mon, 08 Apr 2013 04:19:11 +0000
Received: by mail-pd0-f172.google.com with SMTP id 5so3025628pdd.17
 for <kexec@lists.infradead.org>; Sun, 07 Apr 2013 21:19:08 -0700 (PDT)
Date: Mon, 8 Apr 2013 12:18:33 +0800
From: Wang YanQing <udknight@gmail.com>
Subject: Re: [PATCH] i386:kexec-bzImage: Use "\0" as command line instead of
 empty command line
Message-ID: <20130408041833.GA6810@udknight>
References: <20130403094356.GA7259@udknight> <515FB809.3020103@gmail.com>
 <20130407010103.GA2176@udknight> <51610A32.6080200@cn.fujitsu.com>
 <20130407093540.GA4046@udknight> <20130408010804.GA2241@udknight>
 <51623AFD.9000605@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51623AFD.9000605@cn.fujitsu.com>
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
To: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
Cc: jbarnes@sgi.com, tjd21@cl.cam.ac.uk, khalid.aziz@hp.com, kexec@lists.infradead.org, horms@verge.net.au, ebiederm@xmission.com, hari@in.ibm.com, Zhang Yanfei <zhangyanfei.yes@gmail.com>

On Mon, Apr 08, 2013 at 11:35:25AM +0800, Zhang Yanfei wrote:
> I tried 3.8.0 kernel. Unfortunately, panicked again. For some reason, I didn't
> see the panic message.
Maybe it hasn't paniced. Could you ping it from another machine? I meet 
an situation which looks like panic after I run kexec -e, but it isn't 
except the screen is hang, I can't see any output from screen, but I can 
login in through ssh from another machine, of course, it is another story.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
