Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp.eu.citrix.com ([46.33.159.39])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UDFI1-0002QG-O9
 for kexec@lists.infradead.org; Wed, 06 Mar 2013 14:25:54 +0000
From: Ian Jackson <Ian.Jackson@eu.citrix.com>
MIME-Version: 1.0
Message-ID: <20791.20974.5321.191502@mariner.uk.xensource.com>
Date: Wed, 6 Mar 2013 14:25:50 +0000
Subject: Re: [Xen-devel] [PATCH 7/8] libxc: add hypercall buffer arrays
In-Reply-To: <1361468894-18655-8-git-send-email-david.vrabel@citrix.com>
References: <1361468894-18655-1-git-send-email-david.vrabel@citrix.com>
 <1361468894-18655-8-git-send-email-david.vrabel@citrix.com>
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
To: David Vrabel <david.vrabel@citrix.com>
Cc: Daniel Kiper <daniel.kiper@oracle.com>, kexec@lists.infradead.org, Ian Campbell <Ian.Campbell@citrix.com>, xen-devel@lists.xen.org

David Vrabel writes ("[Xen-devel] [PATCH 7/8] libxc: add hypercall buffer arrays"):
> From: David Vrabel <david.vrabel@citrix.com>
> 
> Hypercall buffer arrays are used when a hypercall takes a variable
> length array of buffers.

Ian Campbell did the hypercall buffers and is the relevant authority,
so CC'ing him.

Ian.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
