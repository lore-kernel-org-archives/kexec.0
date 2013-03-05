Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UCguV-0005oo-Ks
 for kexec@lists.infradead.org; Tue, 05 Mar 2013 01:43:20 +0000
Date: Tue, 5 Mar 2013 10:43:16 +0900
From: Simon Horman <simon@horms.net>
Subject: Re: kexec,x86: Use macro CRASH_MAX_MEMMAP_NR for clarification
Message-ID: <20130305014316.GF16128@verge.net.au>
References: <512C8AA6.2020503@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <512C8AA6.2020503@cn.fujitsu.com>
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
To: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
Cc: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On Tue, Feb 26, 2013 at 06:12:54PM +0800, Zhang Yanfei wrote:
> For the allocation, using CRASH_MAX_MEMMAP_NR instead of KEXEC_MAX_SEGMENTS + 1 
> seems more understandable.

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
