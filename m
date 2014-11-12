Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XofMC-00050D-8r
 for kexec@lists.infradead.org; Wed, 12 Nov 2014 21:21:40 +0000
Date: Wed, 12 Nov 2014 16:21:14 -0500 (EST)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <1764963172.7408609.1415827274280.JavaMail.zimbra@redhat.com>
In-Reply-To: <548583707.7386011.1415824908540.JavaMail.zimbra@redhat.com>
References: <5461F18C.2080400@redhat.com>
 <20141111130913.11eec0a3@hananiah.suse.cz>
 <20141112.120838.303682123986142686.d.hatayama@jp.fujitsu.com>
 <20141112090441.3ee42632@hananiah.suse.cz> <546373B8.70103@redhat.com>
 <20141112194325.246ff381@hananiah.suse.cz> <5463C35C.2000103@redhat.com>
 <548583707.7386011.1415824908540.JavaMail.zimbra@redhat.com>
Subject: Re: [Crash-utility] uniquely identifying KDUMP files that originate
 from QEMU
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
To: "Discussion list for crash utility usage,
 maintenance and development" <crash-utility@redhat.com>
Cc: kexec@lists.infradead.org, tumanova@linux.vnet.ibm.com, Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org



----- Original Message -----

> > Can you fetch that in "crash"? If you can, then there's nothing to do on
> > the qemu side (and I'll have to apologize for spamming a bunch of lists
> > :/).

Well, let's be clear -- I was the one who put you up to it...

But no apology is required -- and in fact, if today's discussion results in
the "phys_base" vmcoreinfo issue being resolved in the kernel, we'll all be
eternally grateful.

Thanks again,
  Dave



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
