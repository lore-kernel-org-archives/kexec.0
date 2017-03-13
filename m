Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.87 #1 (Red Hat Linux))
 id 1cnLl4-0001Qp-Om
 for kexec@lists.infradead.org; Mon, 13 Mar 2017 08:55:16 +0000
Date: Mon, 13 Mar 2017 09:54:43 +0100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2 1/1] Don't use %L width specifier with integer values
Message-ID: <20170313085443.GA22378@verge.net.au>
References: <20170311031215.3628-1-philipp@redfish-solutions.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20170311031215.3628-1-philipp@redfish-solutions.com>
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
To: Philip Prindeville <philipp@redfish-solutions.com>
Cc: Philip Prindeville <philipp@fedoraproject.org>, kexec@lists.infradead.org

On Fri, Mar 10, 2017 at 08:12:15PM -0700, Philip Prindeville wrote:
> From: Philip Prindeville <philipp@redfish-solutions.com>
> 
> MUSL doesn't support %L except for floating-point arguments; therefore,
> %ll must be used instead with integer arguments.

I apologise for my ignorance; what is MUSL?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
