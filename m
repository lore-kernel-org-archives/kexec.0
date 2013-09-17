Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from smtp02.citrix.com ([66.165.176.63])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VLs7T-0000ll-Km
 for kexec@lists.infradead.org; Tue, 17 Sep 2013 10:02:55 +0000
Message-ID: <523828B8.1090509@citrix.com>
Date: Tue, 17 Sep 2013 11:02:32 +0100
From: David Vrabel <david.vrabel@citrix.com>
MIME-Version: 1.0
Subject: Re: [Xen-devel] [PATCH 1/5] purgatory: put variables altered by kexec
 in .data not .bss
References: <1379016042-22510-1-git-send-email-david.vrabel@citrix.com>
 <1379016042-22510-2-git-send-email-david.vrabel@citrix.com>
 <20130916124302.GC14630@debian70-amd64.local.net-space.pl>
 <5236FE07.2010405@citrix.com>
 <20130917013309.GA301@debian70-amd64.local.net-space.pl>
 <20130917081704.GA25707@ocelot.phlegethon.org> <52382808.7070902@citrix.com>
In-Reply-To: <52382808.7070902@citrix.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Tim Deegan <tim@xen.org>
Cc: Daniel Kiper <daniel.kiper@oracle.com>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, xen-devel@lists.xen.org

On 17/09/13 10:59, David Vrabel wrote:
>
> I'm using 4.7.2 and it does support the option and it is correctly being

4.4.5.

David

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
