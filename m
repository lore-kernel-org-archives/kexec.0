Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1acqdW-0000XW-BG
 for kexec@lists.infradead.org; Mon, 07 Mar 2016 08:35:31 +0000
Date: Mon, 7 Mar 2016 16:39:09 +0800
From: Minfei Huang <mhuang@redhat.com>
Subject: Re: [PATCH v3] Improve the performance of --num-threads -d 31
Message-ID: <20160307083909.GA21811@dhcp-128-25.nay.redhat.com>
References: <1457080544-16469-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
 <20160307070458.GA6016@dhcp-128-25.nay.redhat.com>
 <BE691E4CBA06214BB0FA8EEFC7C61A4D0181E2B9@BPXM02GP.gisp.nec.co.jp>
 <BE691E4CBA06214BB0FA8EEFC7C61A4D0181E3B3@BPXM02GP.gisp.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BE691E4CBA06214BB0FA8EEFC7C61A4D0181E3B3@BPXM02GP.gisp.nec.co.jp>
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
To: Minoru Usui <min-usui@ti.jp.nec.com>
Cc: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On 03/07/16 at 08:16am, Minoru Usui wrote:
> Hi, Minfei
> > >
> > > Hi, Wenjian.
> > >
> > > Since your patch applied Minoru Usui's draft patch, I have vierified it.
> > > And it works well under 4T memory.
> > >
> > > applied makedumpfile with option -d 31
> > > real    3m48.681s
> > >
> > > applied makedumpfile with option -d 31 --num-threads 32
> > > real    3m3.533s
> > >
> > > original makedumpfile with option -d 31
> > > real    3m57.163s
> > >
> > > Now with or without option --num-thread, it takes almost same time.
> > 
> > Thank you for your test on big memory machine.
> > I am relieved to see your test results.
> 
> I'm sorry, I may be misunderstood.
> Is above result is Zhou's v3 patch or v2 + my patch?

I have applied Zhou's v3 patch.

> 
> If above result is Zhou's v3 patch, could you test v2 + my patch?

Your patch fails to be applied based on Zhou's v2 patch. There is a rej
file to be generated during applying.

Thanks
Minfei

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
