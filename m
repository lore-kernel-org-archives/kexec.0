Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1er1QH-0005Sl-Aa
 for kexec@lists.infradead.org; Wed, 28 Feb 2018 13:05:35 +0000
Date: Wed, 28 Feb 2018 14:05:12 +0100
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Subject: Re: [PATCH 4/5] kexec: fallback to KEXEC_LOAD when KEXEC_FILE_LOAD
 is not supported.
Message-ID: <20180228140512.0b04001d@kitsune.suse.cz>
In-Reply-To: <ebc4bc6f1dc7d62ba5c81f40c7f7d83a8ae3eb5d.1519646210.git.msuchanek@suse.de>
References: <e810acd57d9fc2d7ba3b0e95d470c20de9948462.1519646210.git.msuchanek@suse.de>
 <ebc4bc6f1dc7d62ba5c81f40c7f7d83a8ae3eb5d.1519646210.git.msuchanek@suse.de>
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
To: msuchanek@suse.de, kexec@lists.infradead.org
Cc: Tony Jones <tonyj@suse.com>, horms@verge.net.au, Petr Tesarik <ptesarik@suse.cz>

On Mon, 26 Feb 2018 13:00:37 +0100
Michal Suchanek <msuchanek@suse.de> wrote:

> Not all architectures implement KEXEC_FILE_LOAD. However, on some
> archiectures KEXEC_FILE_LOAD is required when secure boot is enabled
> in locked-down mode. Previously users had to select the
> KEXEC_FILE_LOAD syscall with undocumented -s option. However, if they
> did pass the option kexec would fail on architectures that do not
> support it.
> 
> When no option is passed to select one syscall or the other try
> KEXEC_FILE_LOAD and fall back to KEXEC_LOAD when not suported.
> 
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
>  kexec/kexec.c | 43 +++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 39 insertions(+), 4 deletions(-)
> 
> diff --git a/kexec/kexec.c b/kexec/kexec.c
> index a95cfb473d6b..14f56e466a95 100644
> --- a/kexec/kexec.c
> +++ b/kexec/kexec.c
> @@ -1243,6 +1243,7 @@ int main(int argc, char *argv[])
>  	int do_unload = 0;
>  	int do_reuse_initrd = 0;
>  	int do_kexec_file_syscall = 0;
>+	int do_kexec_fallback = 1;

do_kexec_file_syscall should be also set to 1 for the fallback to be
the default. Or we need the fallback option to set do_kexec_fallback
separately.

Thanks

Michal

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
