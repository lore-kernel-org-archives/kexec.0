Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e32.co.us.ibm.com ([32.97.110.150])
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1HlJ4W-0001h3-Hz
	for kexec@lists.infradead.org; Tue, 08 May 2007 07:21:17 +0100
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l486HXWQ020638
	for <kexec@lists.infradead.org>; Tue, 8 May 2007 02:17:33 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l486KrqI166162
	for <kexec@lists.infradead.org>; Tue, 8 May 2007 00:20:53 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l486Krwu006453
	for <kexec@lists.infradead.org>; Tue, 8 May 2007 00:20:53 -0600
Date: Tue, 8 May 2007 11:50:19 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: [patch 1/5] kexec debug output improvments
Message-ID: <20070508062019.GC5400@in.ibm.com>
References: <20070507235727.631477448@am.sony.com>>
	<463FBE27.4060402@am.sony.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <463FBE27.4060402@am.sony.com>
Reply-To: vgoyal@in.ibm.com
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Geoff Levand <geoffrey.levand@am.sony.com>
Cc: kexec@lists.infradead.org

On Mon, May 07, 2007 at 05:02:47PM -0700, Geoff Levand wrote:
> kexec debug output improvments.
>  - Add better type checking for the debug output macro dfprintf().
>  - Add a convenence macro dprintf().
> 
> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
> ---
>  kexec/kexec.h |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> --- kexec-tools-hacked.orig/kexec/kexec.h
> +++ kexec-tools-hacked/kexec/kexec.h
> @@ -217,10 +217,12 @@ int parse_iomem_single(char *str, uint64
> 
>  #define MAX_LINE	160
> 
> +#define dprintf(args...) dfprintf(stdout, args)
>  #ifdef DEBUG
> -#define dfprintf(args...)	do {fprintf(args);} while(0)
> +#define dfprintf(_f, _args...) do {fprintf(_f, _args);} while(0)

Should't dprintf() also be inside #ifdef DEBUG?

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
