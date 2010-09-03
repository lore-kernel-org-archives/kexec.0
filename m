Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from moutng.kundenserver.de ([212.227.126.171])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OrUiv-0005f4-WE
	for kexec@lists.infradead.org; Fri, 03 Sep 2010 11:46:26 +0000
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: fix /proc/vmcore seek
Date: Fri, 3 Sep 2010 13:45:50 +0200
References: <201009021420.19914.arnd@arndb.de>
	<2091492614.1926861283437436205.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<20100903100050.1943c4c3.oomichi@mxs.nes.nec.co.jp>
In-Reply-To: <20100903100050.1943c4c3.oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Message-Id: <201009031345.50837.arnd@arndb.de>
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
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: CAI Qian <caiqian@redhat.com>, fweisbec@gmail.com, mingo@elte.hu, kexec <kexec@lists.infradead.org>, viro@zeniv.linux.org.uk, jkacur@redhat.com, akpm@linux-foundation.org, tglx@linutronix.de, kamezawa hiroyu <kamezawa.hiroyu@jp.fujitsu.com>

On Friday 03 September 2010, Ken'ichi Ohmichi wrote:
> Thank you for investigating.
> IIUC, this problem may happen if using "cp" command instead of
> makedumpfile.
> 
> Does the following method in generic_file_llseek_unlocked() fail ?
> Is inode->i_sb->s_maxbytes too small ?
> 
>      65         if (offset < 0 || offset > inode->i_sb->s_maxbytes)
>      66                 return -EINVAL;
> 

Yes, that is the main difference between generic_file_llseek and
default_llseek, besides the use of the BKL. We have discussed
changing this before, but so far without a conclusive answer.

If we can come up with a better test here, we might be able
to just kill default_llseek in favor of generic_file_llseek.

The problem is handling the special cases here. For a /proc file,
s_maxbytes is probably always zero, but that could be changed,
same for file systems using get_sb_single.
For some reason, get_sb_pseudo sets does set s_maxbytes while
get_sb_single/simple_fill_super does not.

Character devices are also special, because the s_maxbytes for
them AFAICT is the one from the file system holding the device,
so using generic_file_llseek would definitely be incorrect for them.

	Arnd

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
