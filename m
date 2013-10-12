Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from g1t0029.austin.hp.com ([15.216.28.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VUoS4-0004ot-Tc
 for kexec@lists.infradead.org; Sat, 12 Oct 2013 01:57:09 +0000
Message-ID: <5258AC58.4060308@hp.com>
Date: Sat, 12 Oct 2013 09:56:40 +0800
From: Jingbai Ma <jingbai.ma@hp.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2] crash utility: fix max_mapnr issue on system has over
 44-bit addressing
References: <20131011094700.13571.24033.stgit@k.asiapacific.hpqcorp.net>
 <1398853173.5067799.1381517552627.JavaMail.root@redhat.com>
In-Reply-To: <1398853173.5067799.1381517552627.JavaMail.root@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Dave Anderson <anderson@redhat.com>
Cc: bhe@redhat.com, nishimura@mxp.nes.nec.co.jp, usui@mxm.nes.nec.co.jp, d hatayama <d.hatayama@jp.fujitsu.com>, lisa mitchell <lisa.mitchell@hp.com>, vgoyal@redhat.com, ruyang@redhat.com, tachibana@mxm.nes.nec.co.jp, kumagai-atsushi@mxc.nes.nec.co.jp, chaowang@redhat.com, kexec@lists.infradead.org, Jingbai Ma <jingbai.ma@hp.com>, crash-utility@redhat.com

On 10/12/2013 02:52 AM, Dave Anderson wrote:
>
> Hello Jingbai,
>
> The old diskdump-compatibility issue has been addressed by this second
> patch, but it fails to work with "split" kdumps.
>
> I only have two sample split compressed kdumps.  Despite the dumpfile
> names, both of them were compressed and filtered with "-c -d31".
>
>
>
> I have temporarily placed the sample split dumpfiles above here for you
> to download and test with:
>
>    http://people.redhat.com/anderson/kdump_split
>
> Let me know when you have copied them so I can clear up the disk space.
>
> Thanks,
>    Dave

I have downloaded the dumpfiles, and have reproduced this issue.
I'm working on this issue now, and will send you a new version soon.

--
Thanks,
Jingbai Ma

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
