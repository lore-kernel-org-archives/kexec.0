Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZTp0d-0005mB-Q3
 for kexec@lists.infradead.org; Mon, 24 Aug 2015 10:29:48 +0000
Date: Mon, 24 Aug 2015 15:59:23 +0530
From: Pratyush Anand <panand@redhat.com>
Subject: Re: [PATCH RFC] Drop release date from kexec-tools version output
Message-ID: <20150824102923.GA21306@dhcppc13.redhat.com>
References: <20150824091005.GA10044@dhcp-16-198.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150824091005.GA10044@dhcp-16-198.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org

On 24/08/2015:05:10:05 PM, Dave Young wrote:
> kexec --version reports like below:
> kexec-tools 2.0.7 released 05 February 2015
> 
> The date string is generated when one run bootstrap script, thus
> it is more like a build date instead of release date.
> Even for distribution like Fedora it will make more sense if it can
> report something like "kexec-tools 2.0.7-1 released 05 February 2015"
> 
> In case building from git tree, the date cause more confusion.
> So let's remove it from version string unless there is better idea
> to resolve the issue.

May be we can take same approach what kernel build takes. Kernel build does not
add build/release string. It just add date and time like "Mon Aug 10 23:38:23 UTC 2015".

$ uname -a
Linux dhcppc13 4.1.5-200.fc22.x86_64 #1 SMP Mon Aug 10 23:38:23 UTC 2015 x86_64
x86_64 x86_64 GNU/Linux

~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
