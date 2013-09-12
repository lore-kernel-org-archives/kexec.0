Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VK7za-0001u4-JF
 for kexec@lists.infradead.org; Thu, 12 Sep 2013 14:35:35 +0000
Received: from zmail15.collab.prod.int.phx2.redhat.com
 (zmail15.collab.prod.int.phx2.redhat.com [10.5.83.17])
 by mx3-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id r8CEZCDW014412
 for <kexec@lists.infradead.org>; Thu, 12 Sep 2013 10:35:12 -0400
Date: Thu, 12 Sep 2013 10:35:12 -0400 (EDT)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <1099586971.12086400.1378996512279.JavaMail.root@redhat.com>
In-Reply-To: <1632896047.12077061.1378995804236.JavaMail.root@redhat.com>
Subject: [PATCH / RFC] makedumpfile header to show LZO/snappy/zlib
MIME-Version: 1.0
Content-Type: multipart/mixed; 
 boundary="----=_Part_12086398_784897997.1378996512276"
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

------=_Part_12086398_784897997.1378996512276
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit


With the advent of LZO and snappy compression support, it would be
helpful if it could be readily determined which type of compression 
was used to create the dumpfile.  

The zlib/LZO/snappy indicator is only found down in the bowels of each 
page_desc structure:
  
  /* page flags */
  #define DUMP_DH_COMPRESSED_ZLIB 0x1     /* page is compressed with zlib */
  #define DUMP_DH_COMPRESSED_LZO  0x2     /* paged is compressed with lzo */
  #define DUMP_DH_COMPRESSED_SNAPPY       0x4
                                          /* paged is compressed with snappy */
  
  /* descriptor of each page for vmcore */
  typedef struct page_desc {
          off_t                   offset;         /* the offset of the page data*/
          unsigned int            size;           /* the size of this dump page */
          unsigned int            flags;          /* flags */
          unsigned long long      page_flags;     /* page flags */
  } page_desc_t;

The compressed kdump's header does contain a "status" flag:

  struct disk_dump_header {
          char                    signature[SIG_LEN];     /* = "KDUMP   " */
          int                     header_version; /* Dump header version */
          struct new_utsname      utsname;        /* copy of system_utsname */
          struct timeval          timestamp;      /* Time stamp */
          unsigned int            status;         /* Above flags */
  ...

which has these 3 flags:

  #define DUMP_HEADER_COMPLETED   0
  #define DUMP_HEADER_INCOMPLETED 1
  #define DUMP_HEADER_COMPRESSED  8

But they are all remnants of the old "diskdump" facility, and none of them
are ever used by makedumpfile.

Any chance that the LZO/snappy/zlib method could also be put up in 
the disk_dump_header? 

Dave

------=_Part_12086398_784897997.1378996512276
Content-Type: text/x-patch; name=compression_header.patch
Content-Disposition: attachment; filename=compression_header.patch
Content-Transfer-Encoding: base64

LS0tIG1ha2VkdW1wZmlsZS0xLjUuNC9tYWtlZHVtcGZpbGUuYy5vcmlnCisrKyBtYWtlZHVtcGZp
bGUtMS41LjQvbWFrZWR1bXBmaWxlLmMKQEAgLTUxNjIsNiArNTE2MiwxNiBAQCB3cml0ZV9rZHVt
cF9oZWFkZXIodm9pZCkKIAlkaC0+Yml0bWFwX2Jsb2NrcyAgPSBkaXZpZGV1cChpbmZvLT5sZW5f
Yml0bWFwLCBkaC0+YmxvY2tfc2l6ZSk7CiAJbWVtY3B5KCZkaC0+dGltZXN0YW1wLCAmaW5mby0+
dGltZXN0YW1wLCBzaXplb2YoZGgtPnRpbWVzdGFtcCkpOwogCW1lbWNweSgmZGgtPnV0c25hbWUs
ICZpbmZvLT5zeXN0ZW1fdXRzbmFtZSwgc2l6ZW9mKGRoLT51dHNuYW1lKSk7CisJaWYgKGluZm8t
PmZsYWdfY29tcHJlc3MgJiBEVU1QX0RIX0NPTVBSRVNTRURfWkxJQikKKwkJZGgtPnN0YXR1cyB8
PSBEVU1QX0RIX0NPTVBSRVNTRURfWkxJQjsgCisjaWZkZWYgVVNFTFpPCisJZWxzZSBpZiAoaW5m
by0+ZmxhZ19jb21wcmVzcyAmIERVTVBfREhfQ09NUFJFU1NFRF9MWk8pCisJCWRoLT5zdGF0dXMg
fD0gRFVNUF9ESF9DT01QUkVTU0VEX0xaTykKKyNlbmRpZgorI2lmZGVmIFVTRVNOQVBQWQorCWVs
c2UgaWYgKGluZm8tPmZsYWdfY29tcHJlc3MgJiBEVU1QX0RIX0NPTVBSRVNTRURfU05BUFBZKQor
CQlkaC0+c3RhdHVzIHw9IERVTVBfREhfQ09NUFJFU1NFRF9TTkFQUFkpCisjZW5kaWYKIAogCXNp
emUgPSBzaXplb2Yoc3RydWN0IGRpc2tfZHVtcF9oZWFkZXIpOwogCWlmICghd3JpdGVfYnVmZmVy
KGluZm8tPmZkX2R1bXBmaWxlLCAwLCBkaCwgc2l6ZSwgaW5mby0+bmFtZV9kdW1wZmlsZSkpCg==

------=_Part_12086398_784897997.1378996512276
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

------=_Part_12086398_784897997.1378996512276--

