Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1U0Qam-00018P-DS
 for kexec@lists.infradead.org; Wed, 30 Jan 2013 05:52:16 +0000
Date: Wed, 30 Jan 2013 14:52:12 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 0/3] Make use of new memmap= kernel parameter syntax
Message-ID: <20130130055209.GA2844@verge.net.au>
References: <1358866935-18458-1-git-send-email-trenn@suse.de>
 <20130130043100.GO28230@verge.net.au>
 <bfc13f3d-3ee2-4b7c-8d25-04718536a05a@email.android.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bfc13f3d-3ee2-4b7c-8d25-04718536a05a@email.android.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: yinghai@kernel.org, x86@kernel.org, kexec@lists.infradead.org, Thomas Renninger <trenn@suse.de>, vgoyal@redhat.com

On Tue, Jan 29, 2013 at 11:40:46PM -0600, H. Peter Anvin wrote:
> The right thing to do as I have discussed with the people involved is to
> modify the memory map data structure to have a new memory type ID for
> memory which is to be dumped.  That eliminates the need to put all this
> info into the command line.

Thanks. I apologise for not following the conversation more closely.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
