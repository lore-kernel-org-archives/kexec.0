Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UP5Ff-00088r-8n
 for kexec@lists.infradead.org; Mon, 08 Apr 2013 06:08:24 +0000
Received: by mail-pd0-f170.google.com with SMTP id 10so3051181pdi.29
 for <kexec@lists.infradead.org>; Sun, 07 Apr 2013 23:08:21 -0700 (PDT)
Date: Mon, 8 Apr 2013 14:07:29 +0800
From: Wang YanQing <udknight@gmail.com>
Subject: Re: [PATCH] i386:kexec-bzImage: Use "\0" as command line instead of
 empty command line
Message-ID: <20130408060729.GA2334@udknight>
References: <20130403094356.GA7259@udknight> <515FB809.3020103@gmail.com>
 <20130407010103.GA2176@udknight> <51610A32.6080200@cn.fujitsu.com>
 <20130407093540.GA4046@udknight> <20130408010804.GA2241@udknight>
 <51623AFD.9000605@cn.fujitsu.com> <20130408035345.GA6651@udknight>
 <516248A4.6030500@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <516248A4.6030500@cn.fujitsu.com>
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

On Mon, Apr 08, 2013 at 12:33:40PM +0800, Zhang Yanfei wrote:
> I think this is ok for we have filled all the real_mode buffer with 0.
I don't think so, it must be somethings wrong, if we had filled all
the real_mode buffer with 0, why do we need my patch to set 
the string termination guard '\0'? 

Does '\0' equal zero, right?

Thanks.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
