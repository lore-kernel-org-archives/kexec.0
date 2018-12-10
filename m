Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo162.gate.nec.co.jp ([114.179.232.162])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWSsb-0005SD-GU
 for kexec@lists.infradead.org; Mon, 10 Dec 2018 21:14:20 +0000
From: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Subject: RE: [PATCH 1/2 v2] kdump: add the vmcoreinfo documentation
Date: Mon, 10 Dec 2018 21:10:41 +0000
Message-ID: <4AE2DC15AC0B8543882A74EA0D43DBEC03564659@BPXM09GP.gisp.nec.co.jp>
References: <20181202030839.29945-1-lijiang@redhat.com>
 <20181202030839.29945-2-lijiang@redhat.com> <20181203150809.GA4794@zn.tnic>
 <779dbae7-f6e2-e9e4-bdd0-0a9e6ec62487@redhat.com>
 <20181205113032.GF29510@zn.tnic>
 <3d1a7e68-34c5-d118-fe09-7c9bc14cce84@redhat.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC0356426E@BPXM09GP.gisp.nec.co.jp>
 <20181210183221.GA5482@zn.tnic>
In-Reply-To: <20181210183221.GA5482@zn.tnic>
Content-Language: en-US
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
To: Borislav Petkov <bp@alien8.de>, lijiang <lijiang@redhat.com>
Cc: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "bhe@redhat.com" <bhe@redhat.com>, Jonathan Corbet <corbet@lwn.net>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "dyoung@redhat.com" <dyoung@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>

-----Original Message-----
> > makedumpfile doesn't have any switch which dumps VMCOREINFO from kcore
> > for now. (I'm thinking to have makedumpfile dump it as debug message,
> > though.)
> 
> Might be useful as people are looking into using VMCOREINFO when
> debugging a live kernel...

Now makedumpfile in 'devel' branch can print VMCOREINFO in /proc/kcore
as debug message with the following command:

# ./makedumpfile --mem-usage /proc/kcore -D
...
VMCOREINFO   :
  OSRELEASE=4.20.0-0.rc2.git0.1.fc30.x86_64
  PAGESIZE=4096
page_size    : 4096
  SYMBOL(init_uts_ns)=ffffffff84213540
  ...

Also, it seems that recent crash utility in git repo with kernel 4.19
or newer can dump it with 'help -n' command:

# ./crash vmlinux /proc/kcore
...
crash> help -n
...
  Elf64_Nhdr:
      n_namesz: 11 ("VMCOREINFO")
      n_descsz: 1955
        n_type: 0 (unknown)

      OSRELEASE=4.20.0-0.rc2.git0.1.fc30.x86_64
      PAGESIZE=4096
      SYMBOL(init_uts_ns)=ffffffff84213540
      ...

Thanks,
Kazu
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
