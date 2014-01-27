Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W7tTw-0002Ii-1d
 for kexec@lists.infradead.org; Mon, 27 Jan 2014 21:12:36 +0000
Message-ID: <52E6CBAA.1080405@suse.cz>
Date: Mon, 27 Jan 2014 22:12:10 +0100
From: Michal Marek <mmarek@suse.cz>
MIME-Version: 1.0
Subject: Re: [PATCH 03/11] bin2c: Move bin2c in scripts/basic
References: <1390849071-21989-1-git-send-email-vgoyal@redhat.com>
 <1390849071-21989-4-git-send-email-vgoyal@redhat.com>
In-Reply-To: <1390849071-21989-4-git-send-email-vgoyal@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>, linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Cc: mjg59@srcf.ucam.org, jkosina@suse.cz, greg@kroah.com, ebiederm@xmission.com, hpa@zytor.com

Dne 27.1.2014 19:57, Vivek Goyal napsal(a):
> Kexec wants to use bin2c and it wants to use it really early in the build
> process. See arch/x86/purgatory/ code in later patches.
> 
> So move bin2c in scripts/basic so that it can be built very early and
> be usable by arch/x86/purgatory/
> 
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
[...]
> diff --git a/scripts/basic/Makefile b/scripts/basic/Makefile
> index 4fcef87..afbc1cd 100644
> --- a/scripts/basic/Makefile
> +++ b/scripts/basic/Makefile
> @@ -9,6 +9,7 @@
>  # fixdep: 	 Used to generate dependency information during build process
>  
>  hostprogs-y	:= fixdep
> +hostprogs-$(CONFIG_IKCONFIG)     += bin2c

Is the CONFIG_IKCONFIG dependency still correct, now that you found
another use of bin2c?

Thanks,
Michal


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
