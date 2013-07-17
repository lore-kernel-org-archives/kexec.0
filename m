Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail.linuxfoundation.org ([140.211.169.12])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UzZLX-0000dJ-D1
 for kexec@lists.infradead.org; Wed, 17 Jul 2013 21:33:15 +0000
Date: Wed, 17 Jul 2013 14:32:50 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v7 0/5] kdump: Allow ELF header creation in new kernel
Message-Id: <20130717143250.5de649f4a0fde9f1a52d73f6@linux-foundation.org>
In-Reply-To: <20130716172421.GA7982@redhat.com>
References: <1373991495-47411-1-git-send-email-holzheu@linux.vnet.ibm.com>
 <20130716172421.GA7982@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, kexec@lists.infradead.org, Jan Willeke <willeke@de.ibm.com>, linux-kernel@vger.kernel.org, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>

On Tue, 16 Jul 2013 13:24:21 -0400 Vivek Goyal <vgoyal@redhat.com> wrote:

> Michael, Hatayama, in case this series can't go in 3.11, do you have other
> ideas where a small hack fix will allow kdump to work on s390 and we
> don't have to revert the mmap() patches.

This would certainly be the preferred option at this stage.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
