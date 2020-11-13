Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-eopbgr1400074.outbound.protection.outlook.com
 ([40.107.140.74] helo=JPN01-TY1-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kdSBB-0007Rh-G2
 for kexec@lists.infradead.org; Fri, 13 Nov 2020 06:03:26 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
 <k-hagio-ab@nec.com>
Subject: RE: [PATCH v5 0/3] makedumpfile/arm64: Add support for ARMv8.2
 extensions
Date: Fri, 13 Nov 2020 06:03:16 +0000
Message-ID: <OSBPR01MB1991603053DAD1DFE82E61EEDDE60@OSBPR01MB1991.jpnprd01.prod.outlook.com>
References: <20200910053305.323365-1-bhsharma@redhat.com>
 <OSBPR01MB199105291C7EE3FB3837538BDD390@OSBPR01MB1991.jpnprd01.prod.outlook.com>
 <OSBPR01MB1991879755CF3620E52BD8AEDDE80@OSBPR01MB1991.jpnprd01.prod.outlook.com>
 <CACi5LpOZEUz=dSojw4VNz3EuUAeWzX7=c4=dYj+6KDqg29iCpw@mail.gmail.com>
In-Reply-To: <CACi5LpOZEUz=dSojw4VNz3EuUAeWzX7=c4=dYj+6KDqg29iCpw@mail.gmail.com>
Content-Language: ja-JP
MIME-Version: 1.0
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
To: Bhupesh Sharma <bhsharma@redhat.com>
Cc: John Donnelly <john.p.donnelly@oracle.com>, "bhupesh.linux@gmail.com" <bhupesh.linux@gmail.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hi Bhupesh,

-----Original Message-----
> > Hopefully I'd like to release the next version of makedumpfile next week.
> >
> > So I'm going to merge the modified 1/3 patch and your 2/3 patch separately
> > from 3/3, I think it can use "MAX_PHYSMEM_BITS" and reduce distribution-specific
> > patches.  If you have any concerns about it, please let me know.
> 
> This looks fine to me. Please feel free to merge the patchset in this way.

Thanks for the reply, merged the two patches.

Kazu

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
