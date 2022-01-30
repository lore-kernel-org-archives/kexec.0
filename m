From: Baoquan He <bhe@redhat.com>
Date: Sun, 30 Jan 2022 10:46:17 +0800
Subject: [PATCH 2/5] docs: kdump: add scp sample to write out the dump file
In-Reply-To: <1643370145-26831-3-git-send-email-yangtiezhu@loongson.cn>
References: <1643370145-26831-1-git-send-email-yangtiezhu@loongson.cn>
 <1643370145-26831-3-git-send-email-yangtiezhu@loongson.cn>
Message-ID: <20220130024617.GB29425@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 01/28/22 at 07:42pm, Tiezhu Yang wrote:
> Except cp and makedumpfile, add scp sample to write out the dump file.
                                      ~~~~~~? You mean example?

I think we just give example here, but not list all cases. seems
adding scp is nothing bad. Anyway, except of the concern for 'sample':

Acked-by: Baoquan He <bhe@redhat.com>

> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  Documentation/admin-guide/kdump/kdump.rst | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
> index d187df2..a748e7e 100644
> --- a/Documentation/admin-guide/kdump/kdump.rst
> +++ b/Documentation/admin-guide/kdump/kdump.rst
> @@ -533,6 +533,10 @@ the following command::
>  
>     cp /proc/vmcore <dump-file>
>  
> +or use scp to write out the dump file between hosts on a network, e.g::
> +
> +   scp /proc/vmcore remote_username at remote_ip:<dump-file>
> +
>  You can also use makedumpfile utility to write out the dump file
>  with specified options to filter out unwanted contents, e.g::
>  
> -- 
> 2.1.0
> 


