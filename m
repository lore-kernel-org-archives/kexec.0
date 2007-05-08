Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e35.co.us.ibm.com ([32.97.110.153])
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1HlJIk-0001mO-MW
	for kexec@lists.infradead.org; Tue, 08 May 2007 07:35:59 +0100
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l486ZgGr004319
	for <kexec@lists.infradead.org>; Tue, 8 May 2007 02:35:42 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l486ZgUa074224
	for <kexec@lists.infradead.org>; Tue, 8 May 2007 00:35:42 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l486ZfXb007072
	for <kexec@lists.infradead.org>; Tue, 8 May 2007 00:35:41 -0600
Date: Tue, 8 May 2007 12:05:39 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
Subject: Re: [patch 5/5] kexec fix ppc64 device-tree mem node
Message-ID: <20070508063539.GG28460@in.ibm.com>
References: <20070507235727.631477448@am.sony.com>>
	<463FBE38.5090901@am.sony.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <463FBE38.5090901@am.sony.com>
Reply-To: mohan@in.ibm.com
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

On Mon, May 07, 2007 at 05:03:04PM -0700, Geoff Levand wrote:
> Change the ppc64 device-tree memory node name spec to match the allowable names
> specified in the booting-without-of document.
>
Hi,

Which part of booting-without-of-document you are refering to use
"memory" instead of "memory@"/"memory@0" node?

Regards,
Mohan.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
