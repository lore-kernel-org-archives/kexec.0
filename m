Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from moutng.kundenserver.de ([212.227.126.186])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1OBthv-000094-Fs
	for kexec@lists.infradead.org; Tue, 11 May 2010 17:57:28 +0000
Message-ID: <4BE99A7B.8050500@nerdbynature.de>
Date: Tue, 11 May 2010 10:57:15 -0700
From: Christian Kujau <lists@nerdbynature.de>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] Fix kexec on powerpc32
References: <20100511174749.19309.44615.stgit@muvarov>
In-Reply-To: <20100511174749.19309.44615.stgit@muvarov>
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
To: Maxim Uvarov <muvarov@gmail.com>
Cc: kexec@lists.infradead.org, uvarov@dev.rtsoft.ru, linuxppc-dev@lists.ozlabs.org, horms@verge.net.au, cbouatmailru@gmail.com

On Tue, 11 May 2010 at 21:47, Maxim Uvarov wrote:
> This patch is required in case if you are using new toolchains.

Ah, thanks I was missing (and looking for) crashdump-powerpc.h
already :-)

Christian
-- 
make bzImage, not war

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
