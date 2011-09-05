Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1R0hgK-0000ki-OP
	for kexec@lists.infradead.org; Mon, 05 Sep 2011 22:30:21 +0000
Date: Tue, 6 Sep 2011 07:29:40 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec: sh: Fixed command line management.
Message-ID: <20110905222940.GA29637@verge.net.au>
References: <1315234944-8230-1-git-send-email-angelo.castello@st.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1315234944-8230-1-git-send-email-angelo.castello@st.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Angelo CASTELLO <angelo.castello@st.com>
Cc: kexec@lists.infradead.org

On Mon, Sep 05, 2011 at 05:02:24PM +0200, Angelo CASTELLO wrote:
> This fixes the command line management to be rightly used by
> elf-sh and zImage-sh type formats. Basically, the issue was on use
> of --append option for both set and append the STRING at the cmdline.
> With this patch we correctly manage the cmdline by means of:
>   --append=STRING           Append STRING to the current kernel command line
>   --command-line=STRING     Set the kernel command line to STRING
> Kexec by default gets and runs new kernel using the current
> kernel command line. Running kexec -h you will see its default options.

Hi Angelo,

I don't believe that the changes to the processing of command-line
that you have made are consistent with the implementation on
other architectures.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
