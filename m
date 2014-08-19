Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XJfOB-0005od-Rn
 for kexec@lists.infradead.org; Tue, 19 Aug 2014 09:07:36 +0000
Date: Tue, 19 Aug 2014 17:05:48 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] kexec: usage printing when specify "-u -p"
Message-ID: <20140819090548.GA23283@dhcp-16-105.nay.redhat.com>
References: <1408437926-2462-1-git-send-email-bhe@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1408437926-2462-1-git-send-email-bhe@redhat.com>
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
To: kexec@lists.infradead.org, horms@verge.net.au

Hi,

About this bug, I think the root cause is the definition of option "-p"
is not very clear. In man page, "-p" means "Load the new kernel for use
on panic." But when do the crsh unloading, "-p" also need be specified
with "-p". This is maing the "-p" confusing. Why an unloading job needs
a loading option.

For this issue, maybe 3 choices can be taken:

1, like this patch has done, it works and fix the error.

2, Just change the description in man page and help message, note people
"-p -u" have to be specified and keep the strict sequence. Exchange will
cause incorrect consequence.

3, Fix the root cause. Make clear the meaning of "-p", it just means the
attribute of action. If with "-p", an crash related job will be done, as for
the action, you need specify "-l" or "-u". If only "-l" and "-u", it's
the loading/unloading actions for kexec. If "-p" is added with "-l" and
"-u", then it's the loading/unloading actions for panic.  Then in code
parsing the "-p" option, it can be changed like below:

diff --git a/kexec/kexec.c b/kexec/kexec.c
index 7e7b604..9b5aa96 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -1277,9 +1277,6 @@ int main(int argc, char *argv[])
                        type = optarg;
                        break;
                case OPT_PANIC:
-                       do_load = 1;
-                       do_exec = 0;
-                       do_shutdown = 0;
                        do_sync = 0;
                        if (do_kexec_file_syscall)
                                kexec_file_flags |= KEXEC_FILE_ON_CRASH;

With this change, if user want to do a panic loading/unloading, he/she
need be specify
"kexec -p -l /boot/vmlinuz-xxx initrd /boot/initramfs-xx ....."
"kexec -u -p"

So what's you guys' opinion?

Thanks
Baoquan

On 08/19/14 at 04:45pm, Baoquan He wrote:
> Currently, unload work will be done successfully when specify "kexec -p -u".
> However, when exchange the sequence like "kexec -u -p" unload work can be
> done too, but with a usage printing.
> 
> This is because in the former sequence, "-p" will do below assignments:
> do_load=0;
> do_unload=1;
> Then "-u" do below assignments.
> do_load=0;
> do_unload=1;
> Nothing wrong happened in this situation. Since the result woule be:
> "do_load==0" and do_unload==1.
> 
> In the latter sequence, the final result will be "do_load==1" and
> "do_unload==1". Then after unload operation, it will go into loading
> code flow. Thsi cause the usage() calling and printing.
> 
> So in this patch add a check when enter into the loading code flow.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  kexec/kexec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kexec/kexec.c b/kexec/kexec.c
> index 7e7b604..87ec26a 100644
> --- a/kexec/kexec.c
> +++ b/kexec/kexec.c
> @@ -1361,7 +1361,7 @@ int main(int argc, char *argv[])
>  		else
>  			result = k_unload(kexec_flags);
>  	}
> -	if (do_load && (result == 0)) {
> +	if (do_load && !do_unload (result == 0)) {
>  		if (do_kexec_file_syscall)
>  			result = do_kexec_file_load(fileind, argc, argv,
>  						 kexec_file_flags);
> -- 
> 1.8.5.3
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
