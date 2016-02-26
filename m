Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aZCVy-00025c-Cv
 for kexec@lists.infradead.org; Fri, 26 Feb 2016 07:08:38 +0000
Date: Fri, 26 Feb 2016 15:08:04 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] kexec/fs2dt.c: wrong dt node fix
Message-ID: <20160226070804.GA6285@dhcp-128-65.nay.redhat.com>
References: <20160226034329.GA4878@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160226034329.GA4878@dhcp-128-65.nay.redhat.com>
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
To: kexec@lists.infradead.org
Cc: Andrew Jones <drjones@redhat.com>, Simon Horman <horms@verge.net.au>

Simon,

Oops, the patchlog need a revise since I tested a local branch with latest
upstream kexec-tools, but it is not necessary in F23.

But the code change is still valid to me, will repost with an updated
patch descriptioin.

On 02/26/16 at 11:43am, Dave Young wrote:
> There is a report for ppc64le kexec fail in below Fedora 23 bug:
> https://bugzilla.redhat.com/show_bug.cgi?id=1310495
> 
> 2nd kernel hangs early because of a regression caused by below commit:
> commit 68262155d8c661586b809bc5301a7dff1c378137
> Author: Andrew Jones <drjones@redhat.com>
> Date:   Fri Nov 20 12:31:53 2015 -0500
> 
>     kexec/fs2dt: cleanup pathname
>     
>     putnode() will add the trailing '/', avoid having two. Also
>     pathstart is unused, get rid of it.
>     
>     Signed-off-by: Andrew Jones <drjones@redhat.com>
>     Signed-off-by: Simon Horman <horms@verge.net.au>
> 
> The actual purpose of the commit is to avoid double slash in pathname.
> But unfortunately in function putnode() we have below magics to get the node
> name:
> 	basename = strrchr(pathname,'/') + 1;
> 	...
> 	strcpy((void *)dt, *basename ? basename : "");
> 	...
> 	strcat(pathname, "/");
> 
> We treat none zero basename as a node name, then concat a slash to open the
> directory for later property handling.
> pathname originally was "/proc/device-tree/" so for the first run of putnode
> it will cause double slashes. With the commit above mentioned there are no
> double slashes but we will copy "device-tree" to dt. Thus kexec kernel is not
> happy..
> 
> Instead let's fix it by only concating slash when the basenanme is not empty
> and restore the initial value of pathname as "/proc/device-tree/"
> 
> Signed-off-by: Dave Young <dyoung@redhat.com>
> ---
>  kexec/fs2dt.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> --- kexec-tools.orig/kexec/fs2dt.c
> +++ kexec-tools/kexec/fs2dt.c
> @@ -577,7 +577,8 @@ static void putnode(void)
>  	strcpy((void *)dt, *basename ? basename : "");
>  	dt += ((plen + 4)/4);
>  
> -	strcat(pathname, "/");
> +	if (*basename)
> +		strcat(pathname, "/");
>  	dn = pathname + strlen(pathname);
>  
>  	putprops(dn, namelist, numlist);
> @@ -804,7 +805,7 @@ static void add_boot_block(char **bufp,
>  
>  void create_flatten_tree(char **bufp, off_t *sizep, const char *cmdline)
>  {
> -	strcpy(pathname, "/proc/device-tree");
> +	strcpy(pathname, "/proc/device-tree/");
>  
>  	dt_cur_size = INIT_TREE_WORDS;
>  	dt_base = malloc(dt_cur_size*4);

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
