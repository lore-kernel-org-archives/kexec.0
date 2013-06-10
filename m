Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from moutng.kundenserver.de ([212.227.17.8])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Um4gp-0006e8-PB
 for kexec@lists.infradead.org; Mon, 10 Jun 2013 16:11:28 +0000
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] vmcore: disable mmap_vmcore() if CONFIG_MMU is not defined
Date: Mon, 10 Jun 2013 18:10:37 +0200
References: <51B593C3.7030609@jp.fujitsu.com>
In-Reply-To: <51B593C3.7030609@jp.fujitsu.com>
MIME-Version: 1.0
Message-Id: <201306101810.37960.arnd@arndb.de>
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
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Monday 10 June 2013, HATAYAMA Daisuke wrote:
> Also, on no-MMU configuration, because we don't export buffer for ELF
> note segment to user-space, we use vzalloc() to allocate the buffer.
> Therefore, we use differnet functions to allocate the buffer for ELF
> note segment. To avoid code duplication, introduce a helper
> alloc_elfnotes_buf().
> 
> Reported-by: Amd Bergmann <arnd@arndb.de>
> Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>

Thanks

Note that my name is Arnd not Amd, otherwise

Acked-by: Arnd Bergmann <arnd@arndb.de>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
