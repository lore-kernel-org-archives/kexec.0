Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from alln-iport-7.cisco.com ([173.37.142.94])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jYYy8-0005QV-4G
 for kexec@lists.infradead.org; Tue, 12 May 2020 17:45:29 +0000
From: "Daniel Walker (danielwa)" <danielwa@cisco.com>
Subject: Re: [REQUEST] makedumpfile: stream compress flat ELF format with libz
Date: Tue, 12 May 2020 17:45:24 +0000
Message-ID: <20200512174523.GM31850@zorba>
References: <20200512172546.GL31850@zorba>
 <69649640-B477-4969-AA2B-2E03587944F1@oracle.com>
In-Reply-To: <69649640-B477-4969-AA2B-2E03587944F1@oracle.com>
Content-Language: en-US
Content-ID: <3CBDD08183FDA64EABCFDBCB08C59582@namprd11.prod.outlook.com>
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
To: John Donnelly <john.p.donnelly@oracle.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>

On Tue, May 12, 2020 at 12:38:42PM -0500, John Donnelly wrote:
 
> 
>   Hi Daniel. 
> 
>    -z happens to be used by tar and rsync to indicate compression ;-) . 
> 
> 

This would be fine with me,

makedumpfile -z -F -E -d 31 /proc/vmcore core.gz


Daniel
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
